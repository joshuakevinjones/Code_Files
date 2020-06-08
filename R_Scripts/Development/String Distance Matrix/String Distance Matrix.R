# every operation comes from one package (stringdist)
require(stringdist)
require(readxl)
require(dplyr)

# load test data

df <- read_xlsx(file.choose(), sheet = "Records")

drop_cols <- c('X__1', 'X__2', 'tax_id')

df <- df %>% select(-one_of(drop_cols))

names(df)

df_a <- filter(df, record_type == "empl")
df_a <- df_a %>% select(ref_no, name)

df_b <- filter(df, record_type == "vendor") %>%
  select(ref_no, name)

a <- as.character(df_a$name)
b <- as.character(df_b$name)

# crossjoin entries from a and b to create format for comparison
d <- expand.grid(a, b)

# rename a and b (just placeholders for now)
names(d) <- c("a_name", "b_name")

stringdist::seq_distmatrix(d$a_name, d$b_name)

d$sd <- stringdist::stringsim(as.character(d$a_name), as.character(d$b_name))

final <- d
final$sd <- as.numeric(final$sd)

filter(final, final$sd > .3)

str(final)

final %>% sort(as.numeric(final$sd))

               