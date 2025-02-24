// IMPROTS
const aedes = require('aedes')();
const net = require('net');

//CONEXÃO COM BANCO
const db = require("./db.js");


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

// 🔹 Lista de tópicos permitidos
const topicosPermitidos = ['temperatura', 'oxigenacao', 'bpm'];

aedes.authorizePublish = (client, packet, callback) => {
    if (!topicosPermitidos.includes(packet.topic)) {
        console.log(`❌ Bloqueado: Cliente ${client ? client.id : 'desconhecido'} tentou publicar em "${packet.topic}"`);
        return callback(new Error('Publicação não permitida neste tópico'));
    }

    console.log(`✅ Permitido: Cliente ${client ? client.id : 'desconhecido'} publicou em "${packet.topic}"`);
    callback(null); // Permite a publicação
};

aedes.on('publish', async (packet, client) => {
    if (client) {
        try {
            if (!(client.id && packet.payload)) {
                throw new Error('Erro de client e payload');
            }

            const data = JSON.parse(packet.payload.toString());

            if (!(data && data.dados_tipo && data.dados_valor && data.dados_generate)) {
                throw new Error('Dado Inválido');
            }

            // 🔹 Insere os dados no banco
            const sql = "INSERT INTO dados (esp_id, dados_tipo, dados_valor, dados_generate) VALUES (?, ?, ?, ?);";
            const dados = [1, data.dados_tipo, data.dados_valor, data.dados_generate];

            const res = await db.query(sql, dados);
            console.log(`✅ Dado inserido no banco: ${res}`);

        } catch (error) {
            console.log(`❌ Erro: ${error.message}`);
        }
    }
});





// //TOPICOS PERMITIDOS
// const topicosPermitidos = ['temperatura', 'oxigenacao', 'bpm'];

// //BLOQUEIA TOPICOS INDESEJADOS
// aedes.authorizePublish = (client, packet, callback) => {
//   if (!topicosPermitidos.includes(packet.topic)) {
//     console.log(`Cliente ${client.id} NÃO pode publicar no tópico ${packet.topic}`);
//     return callback(new Error('Publicação não permitida neste tópico'));
//   }
//   console.log(`Cliente ${client.id} publicou em ${packet.topic}`);
//   callback(null); // Permite a publicação
// };

// // Evento de publicação de mensagens
// aedes.on('publish', async (packet, client) => {
  
//   if (client) {
//     try {
//       //VERIFICA A EXISTENCIA DO USUARIO E MENSAGEM
//       if(!(client.id && packet.payload))
//       {
//         throw new Error("Erro de client e payload");        
//       }
//       //VERIFICA SE O DADOS SÃO VALIDOS
//       const data = JSON.parse(packet.payload.toString());
//       if(!(data && data.dados_tipo && data.dados_valor && data.dados_generate ))
//       {
//         throw new Error("Dado Invalido");
//       }
//       //SQL
//       const sql = "INSERT INTO dados( esp_id, dados_tipo, dados_valor, dados_generate ) VALUES ( ?, ?, ?, ?);"
//       //DADOS
//       const dados = [ 1, data.dados_tipo, data.dados_valor, data.dados_generate]
//       //CADASTRA NO BANCO DE DADOS
//       const res = await db.query( sql, dados)
//       console.log(res);
      
//     //SE DAR ERRO
//     } catch (error) {
//       console.log(error);
//     }
//   }
// });
  
// Evento de inscrição em tópicos
aedes.on('subscribe', (subscriptions, client) => {
  console.log(`Cliente ${client.id} se inscreveu no tópico: ${subscriptions.map(s => s.topic).join(', ')}`);
});
  
// Inicia o servidor
server.listen(PORT, () => {
  console.log(`Broker MQTT rodando na porta ${PORT}`);
});