
const aedes = require('aedes')();
const net = require('net');

const db = require("./db.js")


// Porta do broker MQTT
const PORT = 1883;

// Cria o servidor MQTT
const server = net.createServer(aedes.handle);

// Evento de conexão no broker
aedes.on('client', (client) => {
    
    
    
    console.log(`Cliente conectado: ${client.id}`);


});
  



  // Evento de desconexão
  aedes.on('clientDisconnect', (client) => {
    console.log(`Cliente desconectado: ${client.id}`);
  
  
  });
  
  // Evento de publicação de mensagens
  aedes.on('publish', (packet, client) => {
    if (client) {
      console.log(`Mensagem recebida de ${client.id}: ${packet.payload.toString()}`);
    }
    try {
      const json = JSON.parse(packet.payload.toString());
      console.log('Dados JSON:', json);
      const query = async() =>{
        try {
          const data = [client.id, json.tipo, json.valor, json.time]
          console.log(data);
          const sql = "INSERT INTO informacoes(esp_id, inf_tipo, inf_valor, inf_generate_time) VALUES (?, ?, ?, ?)"
          const res = await db.query(sql, data);
          console.log(res);
          
        } catch (error) {
          console.log(error);
        }
      }
      const res = query()
    } catch (error) {
      console.error('Erro ao converter para JSON:', error.message);
    }
  });
  
  // Evento de inscrição em tópicos
  aedes.on('subscribe', (subscriptions, client) => {
    console.log(`Cliente ${client.id} se inscreveu no tópico: ${subscriptions.map(s => s.topic).join(', ')}`);
  
  
  });
  
  // Inicia o servidor
  server.listen(PORT, () => {
    console.log(`Broker MQTT rodando na porta ${PORT}`);
  });