-- Set schema path to group_m for extraction
SET search_path TO group_m;


-- Insert data into dwh.Veiculo from group_m.Veiculo
INSERT INTO dwh.Veiculo (Cd_Veiculo, Nu_Placa, Nm_Marca, Nm_Modelo, Nm_Cor, Cd_Categoria, Ds_Ar_Condicionado, Ds_Foto)
SELECT
    ID_Veiculo AS Cd_Veiculo,
    Placa AS Nu_Placa,
    Marca AS Nm_Marca,
    Modelo AS Nm_Modelo,
    Cor AS Nm_Cor,
    Grupo_Categoria AS Cd_Categoria,
    Ar_Condicionado AS Ds_Ar_Condicionado,
    Foto_URL AS Ds_Foto
FROM
    group_m.Veiculo;
   
INSERT INTO dwh.Veiculo (Cd_Categoria, Vl_Valor_da_Categoria)
SELECT
	ID_Grupo AS Cd_Categoria,
	Faixa_Valor_Diaria AS Vl_Valor_da_Categoria

FROM group_m.Grupo_Categoria;
   
   

-- Insert data into dwh.Cliente from group_m.Cliente
INSERT INTO dwh.Cliente (Cd_Cliente, Nm_Cliente, Cd_CNPJ_CPF, Endereco, Nu_Telefone, Nm_Email, Cd_CNH, Dt_Validade_CNH)
SELECT
    ID_Cliente AS Cd_Cliente,
    Nome AS Nm_Cliente,
    CPF_CNPJ AS Cd_CNPJ_CPF,
    Endereco,
    Telefone AS Nu_Telefone,
    Email AS Nm_Email,
    Numero_CNH AS Cd_CNH,
    Validade_CNH AS Dt_Validade_CNH
FROM
    group_m.Cliente;

   
-- Insert data into dwh.Reserva from group_m.Reserva = locacao_m
INSERT INTO dwh.Reserva (Cd_Reserva)
SELECT
    ID_Locacao AS Cd_Reserva
FROM
    group_m.Locacao;

   
   
INSERT INTO dwh.Reserva (Dt_Reserva, Dt_Entrega, Dt_Devolucao)
SELECT
    Data_Reserva AS Dt_Reserva,
    Data_Retirada AS Dt_Entrega,
    Data_Devolucao AS Dt_Devolucao
FROM
	group_m.Reserva;
   

 
-- Insert data into dwh.Locacao from group_m.Locacao = reserva_m
INSERT INTO dwh.Locacao (Cd_Locacao, CD_Veiculo, CD_Patio, CD_Cliente, Nu_Total_por_veiculo, Qt_Locacoes_por_veiculo)
SELECT
    ID_Reserva AS Cd_Locacao,
    ID_Veiculo AS CD_Veiculo,
    NULL AS CD_Patio,
    ID_Cliente AS CD_Cliente,
    NULL AS Nu_Total_por_veiculo,
    NULL AS Qt_Locacoes_por_veiculo
FROM
    group_m.Reserva;
  
   
-- Insert data into dwh.Patio from group_m.Patio
INSERT INTO dwh.Patio (Cd_Patio, Nm_Patio)
SELECT
    ID_Patio AS Cd_Patio,
    Nome AS Nm_Patio
FROM
    group_m.Patio;
