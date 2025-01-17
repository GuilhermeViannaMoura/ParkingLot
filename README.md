# Reserva de Vagas de Estacionamento

Como tema do nosso trabalho, escolhemos um sistema de reserva de vagas antecipadas de estacionamento para qualquer tipo de veículo.
## Grupo
Guilherme Moura, Thiago Arruda e Pedro Trink

## Modelo

Segue a descrição das tabelas adotadas no modelo de dados do sistema:

### Login

Representa o login de um usuário ou estacionamento. Possui um `refresh token` para fins de autenticação persistente e uma flag `deactivated` que sinaliza se o usuário excluiu a conta ou não.

### ResetPassword

Utilizado para gerenciar tokens de recuperação de senha.

### User

Modelo dos motoristas do sistema. Carrega atributos como `nome` e `cpf` para identificação do mesmo.

### Favorites

Responsável pelo relacionamento de favoritos. Um motorista com id `user_id` pode adicionar um estacionamento com id `parking_lot_id` como favorito.

### Vehicle

Representa um veículo do motorista. Esse veículo pode ser `CAR`, `MOTORCYCLE` ou `BICYCLE` ou suas respectivas variações elétricas, `ELECTRIC_CAR`, `ELECTRIC_MOTORCYCLE` e `ELECTRIC_BICYCLE`.

### Feedback

Utilizado para armazenar os feedbacks dos estacionamentos em relação a plataforma.

### ParkingLot

Modelo dos estacionamentos do sistema. Possui referências às tabelas **Address** e **Company** para caracterizá-lo.

### Address

Armazena informações de endereços, como `neighborhood`, `city` e `state`, além da posição exata do estacionamento, em latitude e longitude, para fins de mapeamento. 

### ParkingSpot

Representa a categoria de uma vaga em um estacionamento. Cada vaga é caracterizada de seguinte forma:

- tipos de veículo que ela suporta (ex: carro e moto)
- número total de vagas
- início e fim do número da vaga (ex: vagas 1 a 50, vagas 51 a 80)

### Reservation

Representa uma reserva de uma vaga da categoria com id `parking_spot_id` feita por um motorista que possui um veículo com id `vehicle_id` em um estacionamento de id `parking_lot_id`.

### TimelineObject

Armazena a forma como o mesmo estado de uma reserva é exibido de maneiras diferentes para motoristas e estacionamentos.

Por exemplo, o primeiro estado de uma reserva é o de aguardar o estacionamento aceitar a solicitação.

Enquanto que para o motorista esse estado seria exibido como `aguardando estacionamento aceitar`, para o estacionamento seria exibido `aceite a reserva`.

### ReservationTimelineObjects

Representa os diferentes estados de uma reserva ao longo do tempo.

### Conveniences

Conveniência que o estacionamento pode oferecer para os seus clientes, como vaga coberta, segurança, funcionamento 24 horas, etc. As conveniências são definidas de maneira estática para que o estacionamento escolha quais ele possui em seu estabelecimento.

### Availability

Representa os horários de funcionamento do estacionamento, com `start_time` e `end_time` para cada dia da semana `weekday`.

### ConveniencesOnParkingLot

Utilizada para referenciar um estacionamento às suas conveniências.

### Company

Representa a empresa que é proprietária de um estacionamento, possibilitando que exista uma empresa com mais de um estacionamento, como no caso de franquias.







