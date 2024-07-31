#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>

WiFiClient wifiClient;
HTTPClient httpClient;

const char* WIFI_SSID = "HackaTruckVisitantes";
const char* WIFI_PASSWORD = "";
const char* URLGET = "http://192.168.128.247:1880/getid/?id=cbd777075054370a963fa96ff3ce3fa5";
const char* URLPUT = "http://192.168.128.247:1880/senddata";
const char* document_id = "cbd777075054370a963fa96ff3ce3fa5";

// Definindo valores e variáveis usadas na função
const int trigger = 12;
const int echo = 14;

#define VELOCIDADE_DO_SOM 0.0344

long duracao;
float resultado;
String statusVaga;

void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println("Iniciando...");

  Serial.print("Conectando na rede WiFi ");
  Serial.print(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("[INFO] Conectado WiFi IP: ");
  Serial.println(WiFi.localIP());

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(trigger, OUTPUT);
  pinMode(echo, INPUT);
}

float leituraDaDistancia(void) {
  float distancia;
  digitalWrite(trigger, LOW);
  delayMicroseconds(2);
  digitalWrite(trigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger, LOW);

  duracao = pulseIn(echo, HIGH);
  distancia = duracao * VELOCIDADE_DO_SOM / 2;
  return distancia;
}

void updateDocument(const String& rev, const JsonArray& bloco_A) {
  // Cria o payload de atualização com _id, _rev e o array bloco_A atualizado
  String updatePayload;
  DynamicJsonDocument doc(2048);
  doc["_id"] = document_id;
  doc["_rev"] = rev;
  doc["bloco_A"] = bloco_A;

  serializeJson(doc, updatePayload);

  httpClient.begin(wifiClient, URLPUT);
  httpClient.addHeader("Content-Type", "application/json");
  int httpCode = httpClient.PUT(updatePayload);

  if (httpCode == HTTP_CODE_OK) {
    String content = httpClient.getString();
    Serial.println("Atualização bem-sucedida:");
    Serial.println(content);
  } else {
    Serial.println("Falha na atualização:");
    Serial.println(httpCode);
    String content = httpClient.getString();
    Serial.println(content);
  }

  httpClient.end();
}

void loop() {
  // Obtém a distância e determina o status da vaga
  resultado = leituraDaDistancia();
  if (resultado < 8.0) {
    statusVaga = "Vaga ocupada";
  } else {
    statusVaga = "Vaga disponível";
  }

  // Obtém o _rev atual do documento
  httpClient.begin(wifiClient, URLGET);
  int httpCode = httpClient.GET();

  if (httpCode == HTTP_CODE_OK) {
    String response = httpClient.getString();
    Serial.println("Resposta GET:");
    Serial.println(response);

    // Analisa o _rev do JSON retornado
    DynamicJsonDocument doc(2048);
    DeserializationError error = deserializeJson(doc, response);
    if (error) {
      Serial.print("Erro ao analisar JSON: ");
      Serial.println(error.c_str());
      return;
    }

    String current_rev = doc["_rev"].as<String>();
    JsonArray bloco_A = doc["bloco_A"].as<JsonArray>();

    // Atualiza o status da vaga "A1" no array bloco_A
    for (JsonObject vaga : bloco_A) {
      if (vaga["id_vaga"] == "A1") {
        vaga["situacao"] = statusVaga;
        break;
      }
    }

    // Atualiza o documento com o novo status
    updateDocument(current_rev, bloco_A);
  } else {
    Serial.println("Falha na obtenção do documento:");
    Serial.println(httpCode);
    String response = httpClient.getString();
    Serial.println(response);
  }

  httpClient.end();
  delay(10000); // Espera 30 segundos antes de repetir o loop
}
