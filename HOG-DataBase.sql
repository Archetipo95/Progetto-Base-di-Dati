/*Togli dipendenze*/

SET FOREIGN_KEY_CHECKS=0;

/*Elimina tabelle se esistono*/

DROP TABLE IF EXISTS Nazione;
DROP TABLE IF EXISTS Utente;
DROP TABLE IF EXISTS Amico;
DROP TABLE IF EXISTS Lingua;
DROP TABLE IF EXISTS LinguaDisponibile;
DROP TABLE IF EXISTS CasaProduttrice;
DROP TABLE IF EXISTS Gioco;
DROP TABLE IF EXISTS Libreria;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS CategoriaDisponibile;
DROP TABLE IF EXISTS Prodotto;
DROP TABLE IF EXISTS Ordine;
DROP TABLE IF EXISTS Achievement;
DROP TABLE IF EXISTS AchievementSbloccati;
DROP TABLE IF EXISTS AchievementDisponibili;
DROP TABLE IF EXISTS ListaDesideri;

/*Crea tutte le tabelle*/

CREATE TABLE Nazione(
	IdNazione int (3) AUTO_INCREMENT PRIMARY KEY,
	Nome varchar (255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE Utente(
	Username varchar (32) PRIMARY KEY,
	Password varchar (32) NOT NULL,
	Nome varchar (255) NOT NULL,
	Cognome varchar (255) NOT NULL,
	Email varchar (100) NOT NULL,
	Eta int (2)  DEFAULT null,
	Indirizzo varchar (150) NOT NULL,
	IdNazione int (3),
	FOREIGN KEY (IdNazione) REFERENCES nazione(IdNazione)
)ENGINE=InnoDB;

CREATE TABLE Amico(
	IdUtente varchar (32),
	IdAmico varchar (32),
	DataAmicizia date,
	PRIMARY KEY (IdUtente,IdAmico),
	FOREIGN KEY (IdUtente) REFERENCES Utente(Username),
	FOREIGN KEY (IdAmico) REFERENCES Utente(Username)
)ENGINE=InnoDB;

CREATE TABLE Lingua(
	IdLingua int AUTO_INCREMENT PRIMARY KEY,
	Nome VARCHAR (100) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE LinguaDisponibile(
    IdGioco int NOT NULL,
	IdLingua int NOT NULL,
    PRIMARY KEY(IdGioco,IdLingua),
    FOREIGN KEY(IdGioco) REFERENCES Gioco(IdGioco),
	FOREIGN KEY(IdLingua) REFERENCES Lingua(IdLingua)
)ENGINE=InnoDB;

CREATE TABLE CasaProduttrice(
	IdCasaProduttrice int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar (255) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE Gioco(
	IdGioco int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar (255) NOT NULL,
	DataRilascio date NOT NULL,
	Prezzo double(6,2) DEFAULT 0,
	Pegi varchar (2) NOT NULL,
	Requisiti varchar (300) NOT NULL,
	Valutazione int (2) DEFAULT NULL,
	IdCasaProdruttrice int NOT NULL,
	Tipo int DEFAULT 0,
	FOREIGN KEY (idCasaProdruttrice) REFERENCES CasaProdruttrice(IdCasaProduttrice)
)ENGINE=InnoDB;

CREATE TABLE Libreria(
	IdUtente varchar (32) NOT NULL,
	IdGioco int NOT NULL,
	UltimaSessione date DEFAULT NULL,
	OreGiocate int DEFAULT 0,
	Voto int DEFAULT 0,
	PRIMARY KEY(IdUtente,IdGioco),
	FOREIGN KEY(IdUtente) REFERENCES Utente(Username),
	FOREIGN KEY(IdGioco) REFERENCES Gioco(IdGioco)
)ENGINE=InnoDB;

CREATE TABLE Categoria(
	IdCategoria int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar (50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE CategoriaDisponibile(
	IdGioco int NOT NULL,
	IdCategoria int NOT NULL,
	PRIMARY KEY(IdCategoria,IdGioco),
	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
	FOREIGN KEY (IdGioco) REFERENCES Gioco(IdGioco)
)ENGINE=InnoDB;

CREATE TABLE Prodotto(
	IdOrdine int,
	IdGioco int,
	PRIMARY KEY(IdOrdine,IdGioco),
	FOREIGN KEY (IdOrdine) REFERENCES Ordine(IdOrdine),
	FOREIGN KEY (IdGioco) REFERENCES Gioco(IdGioco)
)ENGINE=InnoDB;

CREATE TABLE Ordine(
	IdOrdine int AUTO_INCREMENT PRIMARY KEY,
	IdUtente varchar (32) NOT NULL,
	PrezzoTotale int (6) NOT NULL,
	DataOrdine date NOT NULL,
	StatoOrdine varchar (20) NOT NULL,
	FOREIGN KEY (IdUtente) REFERENCES Utente(Username)
)ENGINE=InnoDB;

CREATE TABLE Achievement(
	IdAchievement int AUTO_INCREMENT PRIMARY KEY,
	Nome varchar (100) NOT NULL,
	Descrizione varchar (250) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE AchievementSbloccati(
	IdAchievement int NOT NULL,
	IdUtente varchar (32) NOT NULL,
	Data date NOT NULL,
	PRIMARY KEY (IdAchievement,IdUtente),
	FOREIGN KEY (IdAchievement) REFERENCES Achievement(IdAchievement),
	FOREIGN KEY (IdUtente) REFERENCES Utente(Username)
)ENGINE=InnoDB;

CREATE TABLE AchievementDisponibili(
	IdAchievement int NOT NULL,
	IdGioco int NOT NULL,
	PRIMARY KEY(IdAchievement,IdGioco),
	FOREIGN KEY (IdAchievement) REFERENCES Achievement(IdAchievement),
	FOREIGN KEY (IdGioco) REFERENCES Gioco(IdGioco)
)ENGINE=InnoDB;

CREATE TABLE ListaDesideri(
	IdLista int AUTO_INCREMENT PRIMARY KEY,
	IdUtente varchar (32) NOT NULL,
	IdGioco int NOT NULL,
	DataAggiunta date NOT NULL,
	FOREIGN KEY (IdUtente) REFERENCES Utente(Username),
	FOREIGN KEY (IdGioco) REFERENCES Gioco(IdGioco)
)ENGINE=InnoDB;

/*Popola le tabelle con i rispettivi file archiviati in una cartella chiamata "File" presente nella stessa directory del file corrente*/

LOAD DATA LOCAL INFILE 'File/Popola-Nazione.txt' INTO TABLE Nazione;
LOAD DATA LOCAL INFILE 'File/Popola-Utente.txt' INTO TABLE Utente;
LOAD DATA LOCAL INFILE 'File/Popola-Amico.txt' INTO TABLE Amico;
LOAD DATA LOCAL INFILE 'File/Popola-Lingua.txt' INTO TABLE Lingua;
LOAD DATA LOCAL INFILE 'File/Popola-LinguaDisponibile.txt' INTO TABLE LinguaDisponibile;
LOAD DATA LOCAL INFILE 'File/Popola-CasaProduttrice.txt' INTO TABLE CasaProduttrice;
LOAD DATA LOCAL INFILE 'File/Popola-Gioco.txt' INTO TABLE Gioco;
LOAD DATA LOCAL INFILE 'File/Popola-Libreria.txt' INTO TABLE Libreria;
LOAD DATA LOCAL INFILE 'File/Popola-Categoria.txt' INTO TABLE Categoria;
LOAD DATA LOCAL INFILE 'File/Popola-CategoriaDisponibile.txt' INTO TABLE CategoriaDisponibile;
LOAD DATA LOCAL INFILE 'File/Popola-Prodotto.txt' INTO TABLE Prodotto;
LOAD DATA LOCAL INFILE 'File/Popola-Ordine.txt' INTO TABLE Ordine;
LOAD DATA LOCAL INFILE 'File/Popola-Achievement.txt' INTO TABLE Achievement;
LOAD DATA LOCAL INFILE 'File/Popola-AchievementSbloccati.txt' INTO TABLE AchievementSbloccati;
LOAD DATA LOCAL INFILE 'File/Popola-AchievementDisponibili.txt' INTO TABLE AchievementDisponibili;
LOAD DATA LOCAL INFILE 'File/Popola-ListaDesideri.txt' INTO TABLE ListaDesideri;

/*Ristabilisci dipendenze*/

SET FOREIGN_KEY_CHECKS=1;

/*1)Trigger controllo aggiornameto prezzi dei giochi*/

DROP TRIGGER IF EXISTS ControlloPrezzo;

DELIMITER $$
CREATE TRIGGER ControlloPrezzo
AFTER UPDATE ON Gioco
FOR EACH ROW
BEGIN
DECLARE num integer(100);
SELECT count(g.IdGioco) INTO num FROM Gioco g WHERE Prezzo='0.00';
IF num>0 THEN 
SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning';
END IF;
END;
$$
DELIMITER ;

/*2)Trigger per controllo di un aventuale cambio di password*/

DROP TRIGGER IF EXISTS upd_pass;

DELIMITER $$
CREATE TRIGGER upd_pass BEFORE UPDATE ON Utente
FOR EACH ROW 
BEGIN
IF new.Password IS NULL OR new.Password = old.Password THEN
SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'Warning password non valida';
END IF;
END$$
DELIMITER ;

/*1) Dato il nome di un utente calcolare quante ore ha giocato in media a tutti i suoi giochi*/

DROP FUNCTION IF EXISTS MediaOreGiocate;

DELIMITER $$
CREATE FUNCTION MediaOreGiocate (user varchar(150))
RETURNS integer (100)
BEGIN 
DECLARE numGiochi integer (50);
DECLARE somma integer (100);
DECLARE media integer (100);
select count(IdGioco) into numGiochi from Libreria where IdUtente=user;
select sum(OreGiocate) into somma from Libreria where IdUtente=user;
SET media=somma/numGiochi;
return media;
END;
$$
DELIMITER ;

/*2a)Dato il nome di un utente mostrare il valore in euro della sua libreria*/
   
DROP FUNCTION IF EXISTS ValoreLibreria;
   
DELIMITER $$
CREATE FUNCTION ValoreLibreria(utente varchar(100))
RETURNS double(6,2)
BEGIN
DECLARE valore double(6,2);
select sum(g.Prezzo) into valore from Libreria l, Gioco g where l.IdGioco=g.IdGioco and l.IdUtente=utente;
return valore;
END;
$$
DELIMITER ;

/*2b)Dato il nome di un utente mostrare il valore in euro della sua lista desideri*/

DROP FUNCTION IF EXISTS ValoreListaDesideri;

DELIMITER $$

CREATE FUNCTION ValoreListaDesideri(utente varchar(100))
RETURNS double(6,2)
BEGIN
DECLARE valore double (6,2);
select sum(g.Prezzo) into valore from Gioco g,Libreria l where g.IdGioco=l.IdGioco and l.IdUtente=utente;
return valore;
END;
$$
DELIMITER ;

/*3)Dato il nome di un gioco dire se è economico oppure costoso in base al prezzo medio degli altri giochi*/


DROP FUNCTION IF EXISTS ValoreGioco;

DELIMITER $$
CREATE FUNCTION ValoreGioco(giocoCercato varchar(50))
RETURNS varchar(50)
BEGIN
DECLARE risultato varchar(50);
DECLARE n integer(10);
DECLARE media double(6,2);
select avg(Prezzo) into media from Gioco;
select Prezzo into n from Gioco where Nome=giocoCercato;
IF n IS NULL THEN SET risultato='Gioco non esistente';
ELSE
IF n<media-10 THEN SET risultato='Economico';END IF;
IF n>=media-10 AND n<=media+10 THEN SET risultato='Nella media';END IF;
IF n>media+10 THEN SET risultato='Costoso';END IF;

END IF;
return risultato;
END;
$$
DELIMITER ;

