
const aedes = require('aedes')();
const net = require('net');

const db = require("./db.js");
const { log, error } = require('console');


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
  aedes.on('publish', async (packet, client) => {
    if (client) {
      try {
        if(!(client.id || packet.payload))
          throw new Error("Erro de client e payload");        
        const data = JSON.parse(packet.payload.toString());
        if(!(data || data.dados_tipo || data.dados_valor || data.dados_generate ))
          throw "error";
        const sql = "INSERT INTO dados( esp_id, dados_tipo, dados_valor, dados_generate ) VALUES ( ?, ?, ?, ?);"
        console.log(data);
      } catch (error) {
        console.log(error);
      }
    }
        /*
      console.log(`Mensagem recebida de ${client.id}: ${packet.payload.toString()}`);
          try {
      
        let jsonString = packet.payload.toString();
        // Converter para JSON
        const data = JSON.parse(jsonString);
        console.log(data);
        const query = `INSERT INTO teste (esp_id, inf_temperatura, inf_bpm, inf_oxigenacao, inf_generate_time) VALUES(?, ?, ?, ?, ?) `
        const res = await db.query(query, [1, data.temperatura, data.bpm, data.oxigenacao, data.date])
        console.log(res);
        
      } catch (error) {
        console.error('Erro ao converter para JSON:', error.message);
      }

        */
        // console.log(packet.payload.toString());
        
  
  
        // const json = JSON.parse(packet.payload.toString());
        // console.log('Dados JSON:', json);
        // const query = async() =>{
        //   try {
        //     //const data = [client.id, json.tipo, json.valor, new Date(Date.now()).toISOString().slice(0, 19).replace("T", " ") /*json.generate*/]
        //     const data = [ client.id, json.temperatura, json.bpm, json.oxigenacao, json.date]
        //     console.log(data);
        //     const sql = "INSERT INTO teste( esp_id, inf_temperatuda, inf_bpm, inf_oxigenação, inf_generate_time) VALUES ( ?, ?, ?, ?, ? )"
        //     //const sql = "INSERT INTO informacoes(esp_id, inf_tipo, inf_valor, inf_generate_time) VALUES (?, ?, ?, ?)"
        //     const res = await db.query(sql, data);
        //     console.log(res);
            
        //   } catch (error) {
        //     console.log(error);
        //   }
        // }
        // const res = query()

  
      // try {
      //   if (client) {
      //     console.log(`Mensagem recebida de ${client.id}: ${packet.payload.toString()}`);
      //   }
      //   const fetchdata = async()=>{
      //     const timestamp = new Date(Date.now()).toISOString().slice(0, 19).replace("T", " ");
      //     console.log(timestamp); // Exemplo: '2025-02-17 14:29:22'
      //     const data =  [ 1,1 , 10, timestamp]
      //     const sql = "INSERT INTO informacoes( esp_id, inf_tipo, inf_valor, inf_generate_time) VALUES (?, ?, ?, ?)";
      //     const res = await db.query(sql, data);
      //     console.log(res);
      //   }
      //   const res =  fetchdata()
      //   console.log("a");
        
      //   } catch (error) {
      //     console.error('Erro ao converter para JSON:', error.message);
      //   }





   
  });
  
  // Evento de inscrição em tópicos
  aedes.on('subscribe', (subscriptions, client) => {
    console.log(`Cliente ${client.id} se inscreveu no tópico: ${subscriptions.map(s => s.topic).join(', ')}`);
  
  
  });
  
  // Inicia o servidor
  server.listen(PORT, () => {
    console.log(`Broker MQTT rodando na porta ${PORT}`);
  });