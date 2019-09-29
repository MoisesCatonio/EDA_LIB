readLines("data/discentes-2019.csv", n = 10)

#### Carregando os datasets ####
discentes <- read.csv2("data/discentes-2019.csv", header = T, stringsAsFactors = F)

exemplares <- read.csv2("data/exemplares.csv", header = T, stringsAsFactors = F)
#559.341

emprestimos_20172 <- read.csv2("data/emprestimos-20172.csv", header = T, stringsAsFactors = F)
emprestimos_20181 <- read.csv2("data/emprestimos-20181.csv", header = T, stringsAsFactors = F)
emprestimos_20182 <- read.csv2("data/emprestimos-20182.csv", header = T, stringsAsFactors = F)
emprestimos_20191 <- read.csv2("data/emprestimos-20191.csv", header = T, stringsAsFactors = F)

emprestimos <- rbind(emprestimos_20172, emprestimos_20181, emprestimos_20182, emprestimos_20191)



discentes <- subset(discentes, select = c("matricula", "ano_ingresso", "tipo_discente", 
                             "nivel_ensino", "nome_curso", "modalidade_educacao", "nome_unidade"))


# Verificar 


# Quais livros não tiveram empréstimos?

idx <- exemplares$codigo_barras %in% emprestimos$codigo_barras 

livros_sem_empres <- exemplares[idx,]
#121.022


# Quais os livros mais requisitados?

freq_emprestimos <- table(emprestimos$codigo_barras)
freq_emprestimos <- data.frame(sort(freq_emprestimos, decreasing = T))
colnames(freq_emprestimos) <- c("livro", "n_emprestimos")
library(ggplot2)
ggplot()+geom_bar(stat="identity",data=freq_emprestimos[1:10,], aes(x = livro, y = n_emprestimos), 
                  color="orange", fill="purple")

# Dos livros mais novos, quantos não estão tendo visibilidade/divulgação 
# (Menos Empréstimos ou nenhum).

# PROBLEMA: Não tem a data de aquisição do exemplar.


# Quais cursos utilizam mais a biblioteca?

idx <- discentes$matricula %in% emprestimos$matricula_ou_siape
cursos_emprestimos <- data.frame(discentes[idx,"nome_curso"])
colnames(cursos_emprestimos) <- "nome_curso"
freq_cursos_emprestimos <- table(cursos_emprestimos$nome_curso)
freq_cursos_emprestimos <- data.frame(sort(freq_cursos_emprestimos, decreasing = T))
colnames(freq_cursos_emprestimos) <- c("nome_curso", "n_emprestimo")
ggplot()+geom_bar(stat="identity",data=na.exclude(freq_cursos_emprestimos[1:10,]), 
                  aes(x = nome_curso, y = n_emprestimo), color="orange", fill="purple")
