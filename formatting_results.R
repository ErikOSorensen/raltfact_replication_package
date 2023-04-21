knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(readr)
library(here)
library(janitor)
library(gt)


col4 <- c(-0.050,
          0.017,
          -0.052,
          0.017,
          2078,
          0.166,
          0.161,
          0.899, # Starting panel B
          -0.039,
          0.018,
          1388,
          0.131,
          0.160, # Starting panel C
          -0.051,
          0.018,
          -0.025,
          0.024,
          -0.072,
          0.019,
          2018,
          0.069,
          0.0023,
          0.159,
          0.159,
          0.190,
          0.144)
col8 <- c(-0.021,
          0.007,
          -0.026,
          0.006,
          2078,
          0.101,
          0.0509,
          0.379, # Starting on panel B
          0.004,
          0.007,
          1388,
          0.073,
          0.0320, # Panel C:
          -0.021,
          0.007,
          -0.020,
          0.008,
          -0.030,
          0.007,
          2078,
          0.063,
          0.0019,
          0.0490,
          0.0480,
          0.0592,
          0.0442)

aO <- read_tsv(here("variants","O","results", "tables", 
                     "Table_2_panel_A.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(O4 = x4, O8 = x8) %>%
  select(c(rown, x1, O4, O8)) %>%
  mutate(O4 = as.numeric(gsub(",","",O4)),
         O8 = as.numeric(gsub(",","",O8)))
aV <- read_tsv(here("variants","V","results", "tables", 
                    "Table_2_panel_A.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(V4 = x4, V8 = x8) %>%
  select(c(rown, x1, V4, V8)) %>%
  mutate(V4 = as.numeric(gsub(",","",V4)),
         V8 = as.numeric(gsub(",","",V8)))

aS <- read_tsv(here("variants","S", "results", "tables", 
                     "Table_2_panel_A.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(S4 = x4, S8 = x8) %>%
  select(c(rown, x1,  S4, S8)) %>%
  mutate(S4 = as.numeric(gsub(",","",S4)),
         S8 = as.numeric(gsub(",","",S8)))
aL <- read_tsv(here("variants","L", "results", "tables", 
                     "Table_2_panel_A.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(L4 = x4, L8 = x8) %>%
  select(c(rown, x1, L4, L8)) %>%
  mutate(L4 = as.numeric(gsub(",","",L4)),
         L8 = as.numeric(gsub(",","",L8)))
aC <- read_tsv(here("variants","C", "results", "tables", 
                     "Table_2_panel_A.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(C4 = x4, C8 = x8) %>% 
  select(c(rown, x1, C4, C8)) %>%
  mutate(C4 = as.numeric(gsub(",","",C4)),
         C8 = as.numeric(gsub(",","",C8)))


panelA <- aO %>% left_join(aV) %>% left_join(aS) %>% left_join(aL) %>% left_join(aC) %>%
  filter(!(rown %in% c(1,6,7))) 

panelA_left  <- panelA %>% select(c(rown,x1,O4,V4,S4,L4,C4))
panelA_right <- panelA %>% select(c(rown,x1,O8,V8,S8,L8,C8))



bO <- read_tsv(here("variants","O","results", "tables", 
                     "Table_2_panel_B.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(O4 = x4, O8 = x8) %>%
  select(c(rown, x1, O4, O8)) %>%
  mutate(O4 = as.numeric(gsub(",","",O4)),
         O8 = as.numeric(gsub(",","",O8)))
bV <- read_tsv(here("variants","V","results", "tables", 
                    "Table_2_panel_B.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(V4 = x4, V8 = x8) %>%
  select(c(rown, x1, V4, V8)) %>%
  mutate(V4 = as.numeric(gsub(",","",V4)),
         V8 = as.numeric(gsub(",","",V8)))
bS <- read_tsv(here("variants","S", "results", "tables", 
                     "Table_2_panel_B.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(S4 = x4, S8 = x8) %>%
  select(c(rown, x1, S4, S8)) %>%
  mutate(S4 = as.numeric(gsub(",","",S4)),
         S8 = as.numeric(gsub(",","",S8)))
bL <- read_tsv(here("variants","L", "results", "tables", 
                     "Table_2_panel_B.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(L4 = x4, L8 = x8) %>%
  select(c(rown, x1, L4, L8)) %>%
  mutate(L4 = as.numeric(gsub(",","",L4)),
         L8 = as.numeric(gsub(",","",L8)))
bC <- read_tsv(here("variants","C", "results", "tables", 
                     "Table_2_panel_B.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(C4 = x4, C8 = x8) %>% 
  select(c(rown, x1, C4, C8)) %>%
  mutate(C4 = as.numeric(gsub(",","",C4)),
         C8 = as.numeric(gsub(",","",C8)))


panelB <- bO %>% left_join(bV) %>%  left_join(bS) %>% left_join(bL) %>% left_join(bC) %>%
  filter(rown!=1) 

panelB_left <- panelB %>% select(c(rown,x1,O4, V4, S4, L4, C4))
panelB_right <- panelB %>% select(c(rown,x1,O8, V8, S8, L8, C8))


cO <- read_tsv(here("variants","O","results", "tables", 
                     "Table_2_panel_C.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(O4 = x4, O8 = x8) %>%
  select(c(rown, x1, O4, O8)) %>%
  mutate(O4 = as.numeric(gsub(",","",O4)),
         O8 = as.numeric(gsub(",","",O8)))
cV <- read_tsv(here("variants","V","results", "tables", 
                    "Table_2_panel_C.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(V4 = x4, V8 = x8) %>%
  select(c(rown, x1, V4, V8)) %>%
  mutate(V4 = as.numeric(gsub(",","",V4)),
         V8 = as.numeric(gsub(",","",V8)))
cS <- read_tsv(here("variants","S", "results", "tables", 
                     "Table_2_panel_C.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(S4 = x4, S8 = x8) %>%
  select(c(rown, x1, S4, S8)) %>%
  mutate(S4 = as.numeric(gsub(",","",S4)),
         S8 = as.numeric(gsub(",","",S8)))

cL <- read_tsv(here("variants","L", "results", "tables", 
                     "Table_2_panel_C.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(L4 = x4, L8 = x8) %>%
  select(c(rown, x1, L4, L8)) %>%
  mutate(L4 = as.numeric(gsub(",","",L4)),
         L8 = as.numeric(gsub(",","",L8)))

cC <- read_tsv(here("variants","C", "results", "tables", 
                     "Table_2_panel_C.txt")) %>% janitor::clean_names() %>%
  mutate(rown = row_number()) %>%
  rename(C4 = x4, C8 = x8) %>% 
  select(c(rown, x1, C4, C8)) %>%
  mutate(C4 = as.numeric(gsub(",","",C4)),
         C8 = as.numeric(gsub(",","",C8)))


panelC <- cO %>% left_join(cV) %>% left_join(cS) %>% left_join(cL) %>% left_join(cC) %>%
  filter(rown!=1) 

panelC_left <- panelC %>% select(c(rown,x1,O4,V4,S4,L4,C4))
panelC_right <- panelC %>% select(c(rown,x1,O8,V8,S8,L8,C8))

left_panels <- panelA_left %>% bind_rows(panelB_left) %>% bind_rows(panelC_left) 
left_panels$paper4 <- col4
Column4 <- left_panels %>%
  select(-rown) %>%
  select(c(x1,paper4,O4,V4,S4,L4,C4 )) %>%
  gt() %>% 
  fmt_integer(2:7, rows = c(5,11,20)) %>%
  fmt_number(3:7, rows = c(1,3,9,14,16,18), decimals = 5) %>%
  fmt_number(c(3:5,7), rows=c(6,12,21), decimals = 5) %>%  # R2
  fmt_number(3:7, rows = c(7,8,13,22:26), decimals = 5) %>% # Other added stats
  fmt_number(2, rows = c(1,3,6:9,12:14,16,18,21,23:26), decimals = 3) %>%
  fmt_number(2, rows = c(22), decimals = 4) %>%
  fmt(3:7, rows=c(2,4,10,15,17,19), 
      fns = function(x) {
        paste0("(",format(x,nsmall=5, digits=3),")")
      }) %>%
  fmt(2, rows=c(2,4,10,15,17,19), 
      fns = function(x) {
        paste0("(",format(x,nsmall=3, digits=3),")")
      }) %>%
  tab_header("Average treatment effects (intent)") %>%
  tab_row_group(label="Panel C: Actual compared to predicted sharing for viewers and non-viewers",
                rows=14:26) %>%
  tab_row_group(label="Panel B: Average treatment effect on sharing fact-checking",
                rows = 9:13) %>%
  tab_row_group(label="Panel A: Average treatment effect of sharing alt-facts",
                rows = 1:8) 
gtsave(Column4, here("report","Column4.tex"))

right_panel <- panelA_right %>% bind_rows(panelB_right) %>% bind_rows(panelC_right) 
right_panel$paper8 <- col8
Column8 <- right_panel %>%
  select(c(x1,paper8,O8,V8,S8,L8,C8 )) %>%
  gt() %>% 
  fmt_integer(2:7, rows = c(5,11,20)) %>%
  fmt_number(3:7, rows = c(1,3,9,14,16,18), decimals = 5) %>%
  fmt_number(c(3:5,7), rows=c(6,12,21), decimals = 5) %>%  # R2
  fmt_number(3:7, rows = c(7,8,13,22:26), decimals = 5) %>% # Other added stats
  fmt_number(2, rows = c(1,3,6,8,9,12,14,16,18,21), decimals = 3) %>%
  fmt_number(2, rows = c(7,13,22:26), decimals = 4) %>%
  fmt(3:7, rows=c(2,4,10,15,17,19), 
      fns = function(x) {
        paste0("(",format(x,nsmall=5, digits=3),")")
      }) %>%
  fmt(2, rows=c(2,4,10,15,17,19), 
      fns = function(x) {
        paste0("(",format(x,nsmall=3, digits=3),")")
      }) %>%
  tab_header("Average treatment effects (action)") %>%
  tab_row_group(label="Panel C: Actual compared to predicted sharing for viewers and non-viewers",
                rows=14:26) %>%
  tab_row_group(label="Panel B: Average treatment effect on sharing fact-checking",
                rows = 9:13) %>%
  tab_row_group(label="Panel A: Average treatment effect of sharing alt-facts",
                rows = 1:8) 
gtsave(Column8, here("report","Column8.tex"))


sessionInfo()

