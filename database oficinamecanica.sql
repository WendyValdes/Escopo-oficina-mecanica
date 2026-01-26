-- criando databese para officina mecanica
-- drop database ofmecanica;
create database ofmecanica;
use ofmecanica;

-- criando a tabela clientes
create table Client(
	idClient int auto_increment primary key not null,
    Cname varchar(40) not null,
    CPF char(9) not null,
    Adress varchar(255),
    Phone varchar(20),
	constraint unique_cpf_client unique (CPF)
);

alter table Client auto_increment=1;
	
-- criando a tabela veiculo
create table Vehicle(
	idVehicle int primary key auto_increment not null,
    idClient int,
    LicensePlate varchar(10) not null,
    Model varchar(10) not null,
    constraint fk_vehicle_client foreign key (idClient) references Client(idClient),
	constraint unique_LicensePlate unique (LicensePlate)
);

alter table Vehicle auto_increment=1;

-- criar a tabela mecanico
create table Mechanic(
	idMechanic int auto_increment not null primary key,
    Mname varchar(40) not null,
    Adress varchar(255),
    Specialty varchar(20),
    Phone varchar(20) not null,
    CPF char(9) not null,
    constraint unique_cpf_mechanic unique (CPF)
);

alter table Mechanic auto_increment=1;

-- criar a tabela equipes
create table Team(
	idTeam  int auto_increment not null primary key,
    Tname varchar(20)
);

alter table Team auto_increment=1;

-- criando tabela composição das equipes
create table TeamComposition(
	idTeam int,
	idMechanic int,
    constraint fk_teamcomp_team foreign key (idTeam) references Team(idTeam),
    constraint fk_teamcomp_mechanic foreign key (idMechanic) references Mechanic(idMechanic)
);

-- criar a tabela ordem de serviço
create table ServiceOrder(
	idServiceOrder int auto_increment not null primary key,
    IssueDate date,
    CompletionDate date,
    Price float,
    Status enum('Concluido', 'Em andamento', 'Não iniciado') default 'Em andamento',
    idClient int,
    idVehicle int,
    idTeam int,
    constraint fk_ServiceOrder_client foreign key (idClient) references Client(idClient),
    constraint fk_ServiceOrder_vehicle foreign key (idVehicle) references Vehicle(idVehicle),
    constraint fk_ServiceOrder_team foreign key (idTeam) references Team(idTeam)
);  

alter table ServiceOrder auto_increment=1;
 
-- criar a tabela peças
create table Parts(
	idParts int auto_increment not null primary key,
    Price float,
    Pdescription varchar(45)
);

alter table Parts auto_increment=1;

-- criar tabela Ordem de serviço precisou de Peça
create table RequiredPart(
	idParts int,
    idServiceOrder int,
    Quantity int,
    constraint fk_requiredpart_part foreign key (idParts) references Parts(idParts),
    constraint fk_requiredpart_serviceorder foreign key (idServiceOrder) references ServiceOrder(idServiceOrder)
);

-- criar a tabela serviço
create table Service(
	idService int auto_increment not null primary key,
    Sdescription varchar(255),
    Price float
);

alter table Service auto_increment=1;

-- criar a tabela Serviços na OS
create table RequiredService(
	idService int,
    idServiceOrder int,
    Quantity int,
    constraint fk_requiredservice_service foreign key (idService) references Service(idService),
    constraint fk_requiredservice_serviceorder foreign key (idServiceOrder) references ServiceOrder(idServiceOrder)
);

-- populando clientes
INSERT INTO Client (Cname, CPF, Adress, Phone) VALUES
('Ana Silva', '123456789', 'Rua das Flores, 100 - São Paulo/SP', '(11) 91234-5678'),
('Bruno Santos', '987654321', 'Av. Paulista, 1500 - São Paulo/SP',  '(11) 99876-5432'),
('Carlos Pereira', '234567890', 'Rua Minas Gerais, 45 - Belo Horizonte/MG', '(31) 98888-1111'),
('Daniela Costa', '345678901', 'Rua das Acácias, 200 - Campinas/SP', '(19) 97777-2222'),
('Eduardo Lima', '456789012', 'Av. Brasil, 900 - Rio de Janeiro/RJ', '(21) 96666-3333'),
('Fernanda Rocha', '567890123', 'Rua Central, 80 - Curitiba/PR', '(41) 95555-4444'),
('Gustavo Alves', '678901234', 'Rua Bahia, 310 - Salvador/BA', '(71) 94444-5555'),
('Helena Martins', '789012345', 'Av. Independência, 120 - Porto Alegre/RS', '(51) 93333-6666'),
('Igor Fernandes', '890123456', 'Rua São João, 55 - Recife/PE', '(81) 92222-7777'),
('Juliana Barros', '901234567', 'Av. Beira Mar, 400 - Fortaleza/CE', '(85) 91111-8888'),
('Lucas Nogueira', '112233445', 'Rua do Comércio, 600 - Manaus/AM', '(92) 90000-9999'),
('Mariana Teixeira', '223344556', 'Rua das Palmeiras, 70 - Goiânia/GO', '(62) 98888-0000'),
('Nelson Ribeiro', '334455667', 'Av. Sete de Setembro, 230 - Vitória/ES', '(27) 97777-1212'),
('Patrícia Melo', '445566778', 'Rua Projetada, 15 - Natal/RN', '(84) 96666-3434'),
('Rafael Azevedo', '556677889', 'Av. Rio Branco, 101 - São Luís/MA', '(98) 95555-5656'),
('Sabrina Farias', '667788990', 'Rua dos Andradas, 500 - Pelotas/RS', '(53) 94444-7878'),
('Thiago Moreira', '778899001', 'Av. das Américas, 3200 - Rio de Janeiro/RJ', '(21) 93333-9090'),
('Vanessa Pacheco', '889900112', 'Rua Nova, 90 - João Pessoa/PB', '(83) 92222-1010'),
('William Duarte', '990011223', 'Av. Goiás, 410 - Anápolis/GO', '(62) 91111-2020'),
('Yasmin Freitas', '101112131', 'Rua das Laranjeiras, 35 - Aracaju/SE', '(79) 90000-3030');

 -- populando veiculos
 INSERT INTO Vehicle (idClient, LicensePlate, Model) 
 VALUES
(1,  'AAA1A11', 'Gol'),
(1,  'AAA2B22', 'Fox'),
(2,  'BBB1C33', 'Onix'),
(2,  'BBB2D44', 'Prisma'),
(3,  'CCC1E55', 'Civic'),
(4,  'DDD1F66', 'Corolla'),
(4,  'DDD2G77', 'Etios'),
(4,  'DDD3H88', 'Yaris'),
(5,  'EEE1I99', 'Fiesta'),
(6,  'FFF1J10', 'HB20'),
(6,  'FFF2K21', 'Creta'),
(7,  'GGG1L32', 'Argo'),
(8,  'HHH1M43', 'Cruze'),
(8,  'HHH2N54', 'Tracker'),
(9,  'III1O65', 'Uno'),
(10, 'JJJ1P76', 'Renegade'),
(10, 'JJJ2Q87', 'Compass'),
(11, 'KKK1R98', 'Toro'),
(12, 'LLL1S09', 'Hilux'),
(12, 'LLL2T10', 'SW4'),
(13, 'MMM1U21', 'Fusion'),
(14, 'NNN1V32', 'Ka'),
(15, 'OOO1W43', 'Versa'),
(15, 'OOO2X54', 'Kicks');

-- populando mecanicos
INSERT INTO Mechanic (Mname, Adress, Specialty, Phone, CPF) VALUES
('João Pereira',      'Rua das Oficinas, 120 - São Paulo/SP', 'Mecânica Geral', '(11) 91234-1001', '111222333'),
('Carlos Almeida',    'Av. Industrial, 450 - São Paulo/SP',   'Suspensão',      '(11) 91234-1002', '222333444'),
('Marcos Oliveira',   'Rua do Motor, 80 - Campinas/SP',       'Freios',          '(19) 99876-1003', '333444555'),
('Ricardo Santos',    'Av. Brasil, 900 - Rio de Janeiro/RJ',  'Elétrica',        '(21) 98765-1004', '444555666'),
('Fernando Costa',    'Rua das Peças, 60 - Belo Horizonte/MG','Injeção',         '(31) 97654-1005', '555666777'),
('Paulo Nogueira',    'Av. Central, 300 - Curitiba/PR',       'Ar Condicionado', '(41) 96543-1006', '666777888'),
('André Ribeiro',     'Rua Torque, 25 - Porto Alegre/RS',     'Câmbio',          '(51) 95432-1007', '777888999'),
('Lucas Martins',     'Av. dos Mecânicos, 710 - Goiânia/GO',  'Mecânica Geral',  '(62) 94321-1008', '888999000'),
('Rafael Teixeira',   'Rua Pistão, 99 - Salvador/BA',        'Diesel',          '(71) 93210-1009', '999000111'),
('Bruno Farias',      'Av. Engrenagem, 410 - Recife/PE',     'Suspensão',       '(81) 92109-1010', '101112131'),
('Diego Azevedo',     'Rua Válvula, 55 - Manaus/AM',          'Freios',          '(92) 91098-1011', '121314151'),
('Thiago Barros',     'Av. da Injeção, 880 - Fortaleza/CE',  'Injeção',         '(85) 99987-1012', '141516171'),
('Henrique Lopes',    'Rua Alternador, 130 - Natal/RN',      'Elétrica',        '(84) 98876-1013', '161718191'),
('Matheus Rocha',     'Av. do Radiador, 270 - São Luís/MA',  'Ar Condicionado', '(98) 97765-1014', '181920212'),
('Felipe Pacheco',    'Rua do Diferencial, 40 - Cuiabá/MT',  'Câmbio',          '(65) 96654-1015', '202122232');

-- populando equipes
INSERT INTO Team (Tname) 
VALUES
('Equipe A'),
('Equipe B'),
('Equipe C'),
('Equipe D');

-- populando equipes e mecanicos
INSERT INTO TeamComposition (idTeam, idMechanic) 
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 1);

-- populando OS
INSERT INTO ServiceOrder
(IssueDate, CompletionDate, Price, Status, idClient, idVehicle, idTeam)
VALUES
('2025-01-05', '2025-01-07', 850.00, 'Concluido', 1, 1, 1),
('2025-01-10', '2025-01-12', 450.00, 'Concluido', 2, 3, 1),
('2025-01-15', NULL, 1200.00,'Em andamento', 4, 6, 2),
('2025-01-18', NULL, 300.00, 'Em andamento', 5, 7, 2),
('2025-01-20', '2025-01-22', 950.00, 'Concluido', 6, 9, 3),
('2025-01-22', NULL, 150.00, 'Não iniciado', 8, 11, 3),
('2025-01-25', NULL, 600.00, 'Em andamento', 10,14, 1),
('2025-01-28', '2025-01-30', 400.00, 'Concluido', 12, 16, 2);


-- populando peças
INSERT INTO Parts (Price, Pdescription) 
VALUES
(120.00, 'Pastilha de freio'),
(350.00, 'Amortecedor'),
(80.00,  'Filtro de óleo'),
(45.00,  'Filtro de ar'),
(220.00, 'Bateria'),
(180.00, 'Disco de freio'),
(60.00,  'Correia dentada');

-- populando precisando de peças na OS
INSERT INTO RequiredPart (idParts, idServiceOrder, Quantity) 
VALUES
(1, 1, 2),
(6, 1, 2),
(3, 2, 1),
(4, 2, 1),
(2, 3, 2),
(7, 5, 1),
(1, 6, 2),
(5, 7, 1),
(6, 8, 2);

-- populando serviços
INSERT INTO Service (Sdescription, Price) 
VALUES
('Troca de óleo', 120.00),
('Alinhamento e balanceamento', 180.00),
('Revisão completa', 350.00),
('Troca de pastilhas de freio', 200.00),
('Manutenção suspensão', 400.00),
('Diagnóstico eletrônico', 150.00);

-- populando serviços na OS
INSERT INTO RequiredService (idService, idServiceOrder, Quantity) VALUES
(4, 1, 1),
(6, 1, 1),
(1, 2, 1),
(5, 3, 1),
(2, 5, 1),
(3, 6, 1),
(6, 7, 1),
(4, 8, 1);



-- Veiculos por cliente
SELECT 
    c.idClient,
    c.Cname,
    COUNT(v.idVehicle) AS total_veiculos
FROM Client c
LEFT JOIN Vehicle v 
       ON c.idClient = v.idClient
GROUP BY c.idClient, c.Cname
ORDER BY total_veiculos DESC;

-- Equipes e seus mecânicos
SELECT t.Tname, m.Mname
FROM TeamComposition tc
JOIN Team t ON tc.idTeam = t.idTeam
JOIN Mechanic m ON tc.idMechanic = m.idMechanic
ORDER BY t.idTeam;

-- Serviços e peças de uma OS
SELECT so.idServiceOrder, s.Sdescription, rs.Quantity
FROM RequiredService rs
JOIN Service s ON rs.idService = s.idService
JOIN ServiceOrder so ON rs.idServiceOrder = so.idServiceOrder;


-- Peças usadas por OS
SELECT so.idServiceOrder, p.Pdescription, rp.Quantity
FROM RequiredPart rp
JOIN Parts p ON rp.idParts = p.idParts
JOIN ServiceOrder so ON rp.idServiceOrder = so.idServiceOrder;

-- Cliente + Veículo + Ordem de Serviço
SELECT
    c.Cname,
    v.Model,
    v.LicensePlate,
    so.idServiceOrder,
    so.Status,
    so.Price
FROM ServiceOrder so
JOIN Client c   ON so.idClient = c.idClient
JOIN Vehicle v  ON so.idVehicle = v.idVehicle;

-- Ordem de Serviço + Equipe
SELECT
    so.idServiceOrder,
    so.Status,
    so.IssueDate,
    t.Tname
FROM ServiceOrder so
JOIN Team t ON so.idTeam = t.idTeam;

-- Ordem de Serviço + Serviços executados
SELECT
    so.idServiceOrder,
    s.Sdescription,
    rs.Quantity,
    s.Price
FROM RequiredService rs
JOIN Service s      ON rs.idService = s.idService
JOIN ServiceOrder so ON rs.idServiceOrder = so.idServiceOrder;

-- Ordem de Serviço COMPLETA (cliente + veículo + equipe)
SELECT
    so.idServiceOrder,
    c.Cname,
    v.Model,
    v.LicensePlate,
    t.Tname,
    so.Status,
    so.Price
FROM ServiceOrder so
JOIN Client c  ON so.idClient = c.idClient
JOIN Vehicle v ON so.idVehicle = v.idVehicle
JOIN Team t    ON so.idTeam = t.idTeam;

-- Equipes com quantidade de OS
SELECT
    t.Tname,
    COUNT(so.idServiceOrder) AS total_os
FROM Team t
LEFT JOIN ServiceOrder so
       ON t.idTeam = so.idTeam
GROUP BY t.idTeam, t.Tname;




