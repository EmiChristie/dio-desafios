create database if not exists desafio_star_schema
-- drop database desafio_star_schema

use desafio_star_schema

create table dimprofessor (
    pk_professor int primary key,
    nome varchar(200) not null,
    titulacao varchar(100),
    regimetrabalho varchar(50),
    tempodecasa int,
    emailinstitucional varchar(150),
    situacaofuncional varchar(50),
    especialidade varchar(150)
);

create table dimcurso (
    pk_curso int primary key,
    nomecurso varchar(200) not null,
    modalidade varchar(100),
    unidadeacademica varchar(150),
    turno varchar(30),
    grau varchar(100)
);

create table dimdisciplina (
    pk_disciplina int primary key,
    nomedisciplina varchar(200) not null,
    cargahorariatotal int,
    creditos int,
    natureza varchar(50),
    ementa text
);

create table dimdepartamento (
    pk_departamento int primary key,
    nomedepartamento varchar(200) not null,
    centro varchar(150),
    coordenador varchar(150),
    areageral varchar(100)
);

create table dimdata (
    pk_data int primary key,
    datacompleta date not null,
    ano int,
    semestre int,
    mes int,
    nomemes varchar(20),
    trimestre int,
    anoletivo int,
    semanaano int,
    indicadordialetivo bit
);

create table fatoprofessoroferta (
    pk_fato int primary key,
    fk_professor int not null,
    fk_disciplina int not null,
    fk_curso int not null,
    fk_departamento int not null,
    fk_dataoferta int not null,
    cargahorariaministrada int,
    quantidadeturmas int,
    quantidadealunos int,
    periodoletivo varchar(20)
);

alter table fatoprofessoroferta 
add constraint fk_fato_professor
    foreign key (fk_professor) references dimprofessor(pk_professor);

alter table fatoprofessoroferta 
add constraint fk_fato_disciplina
    foreign key (fk_disciplina) references dimdisciplina(pk_disciplina);

alter table fatoprofessoroferta 
add constraint fk_fato_curso
    foreign key (fk_curso) references dimcurso(pk_curso);

alter table fatoprofessoroferta 
add constraint fk_fato_departamento
    foreign key (fk_departamento) references dimdepartamento(pk_departamento);

alter table fatoprofessoroferta 
add constraint fk_fato_data
    foreign key (fk_dataoferta) references dimdata(pk_data);
