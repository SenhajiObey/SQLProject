DROP SCHEMA IF EXISTS projet_sql_2021 CASCADE;
--CREATE SCHEMA--
CREATE SCHEMA projet_sql_2021;


--CREATE TABLE--
CREATE TABLE projet_sql_2021.blocs(
    no_bloc INTEGER NOT NULL CHECK (no_bloc IN (1,2,3)),
    PRIMARY KEY(no_bloc)
);
CREATE TABLE projet_sql_2021.etudiants(
    matricule SERIAL NOT NULL,
    nom VARCHAR(20) NOT NULL,
    prenom VARCHAR(20) NOT NULL,
    email VARCHAR (60) NOT NULL UNIQUE,
    mot_de_passe VARCHAR (60) NOT NULL,
    no_bloc INTEGER NULL,
    PRIMARY KEY(matricule),
    FOREIGN KEY (no_bloc) REFERENCES projet_sql_2021.blocs(no_bloc)
);
CREATE TABLE projet_sql_2021.paes(
    matricule SERIAL NOT NULL,
    est_valide BOOLEAN NOT NULL,
    total_credit INTEGER DEFAULT 0,
    PRIMARY KEY (matricule),
    FOREIGN KEY (matricule) REFERENCES projet_sql_2021.etudiants(matricule)
);
CREATE TABLE projet_sql_2021.ues(
    code_ue VARCHAR(12) UNIQUE CHECK (code_ue SIMILAR TO 'BINV[123].*'),
    nom VARCHAR(60) NOT NULL,
    nombre_credit INTEGER NOT NULL CHECK (nombre_credit>0 && nombre_credit>=30),
    nombre_inscrit INTEGER NULL DEFAULT 0,
    no_bloc INTEGER NOT NULL,
    PRIMARY KEY (code_ue),
    FOREIGN KEY (no_bloc) REFERENCES projet_sql_2021.blocs(no_bloc)
);
CREATE TABLE projet_sql_2021.ligne_ues(
    matricule INTEGER NOT NULL,
    code_ue VARCHAR(12) NOT NULL,
    PRIMARY KEY (matricule,code_ue),
    FOREIGN KEY (matricule) REFERENCES projet_sql_2021.etudiants(matricule),
    FOREIGN KEY (code_ue) REFERENCES projet_sql_2021.ues(code_ue)
);
CREATE TABLE projet_sql_2021.ues_validees(
    matricule INTEGER NOT NULL,
    code_ue VARCHAR(12) NOT NULL,
    PRIMARY KEY (matricule,code_ue),
    FOREIGN KEY (matricule) REFERENCES projet_sql_2021.etudiants(matricule),
    FOREIGN KEY (code_ue) REFERENCES projet_sql_2021.ues(code_ue)
);
CREATE TABLE projet_sql_2021.prerequis(
    code_ue VARCHAR(12) NOT NULL,
    code_prerequis VARCHAR(12) NOT NULL,
    PRIMARY KEY (code_ue,code_prerequis),
    FOREIGN KEY (code_ue) REFERENCES projet_sql_2021.ues(code_ue),
    FOREIGN KEY (code_ue) REFERENCES projet_sql_2021.ues(code_ue)
);




