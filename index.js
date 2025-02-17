// O ESP envia uma request para o broker solicitando registro/autenticação.
// O broker verifica se o ESP já está registrado no banco.
// Caso não exista, o broker cria um usuário para o ESP.
// Gera credenciais criptografadas (chave/token) para autenticação futura.
// Envia essas credenciais ao ESP e salva no banco.
// O status do ESP é atualizado com base na última comunicação (last_update).
// Logs de atividade podem ser mantidos para rastrear conexões/erros.
// A tabela esp_status pode ser simplificada com espid, status, last_update.
// Segurança extra pode ser implementada para evitar cadastros de ESPs não autorizados.
// O sistema é escalável e permite integração futura com outras funcionalidades.




const aedes = require('aedes')();
const net = require('net');

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
  
  
  });
  
  // Evento de inscrição em tópicos
  aedes.on('subscribe', (subscriptions, client) => {
    console.log(`Cliente ${client.id} se inscreveu no tópico: ${subscriptions.map(s => s.topic).join(', ')}`);
  
  
  });
  
  // Inicia o servidor
  server.listen(PORT, () => {
    console.log(`Broker MQTT rodando na porta ${PORT}`);
  });