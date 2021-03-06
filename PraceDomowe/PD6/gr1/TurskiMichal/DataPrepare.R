Name <- c("Eisenbichler M.", "Geiger K.", "Peier K.", "Kobayashi R.", "Stoch K.", 
          "Kraft S.", "Forfang J.", "Johansson R.", "Freitag R.", "Zajc T.", 
          "Huber D.", "Kubacki D.", "Aschenwald P.", "Hayboeck M.", "Ammann S.", 
          "Prevc P.", "Kobayashi J.", "Klimov E.", "Zyla P.", "Ito D.", "Sato Y.", 
          "Koudelka R.", "Jelar Z.", "Fettner M.", "Polasek V.", "Schuler A.", 
          "Boyd-Clowes M.", "Learoyd J.", "Stjernen A.", "Zografski V.")
Nationality <- c("GER", "GER", "SUI", "JPN", "POL", "AUT", "NOR", "NOR", "GER", 
                 "SLO", "AUT", "POL", "AUT", "AUT", "SUI", "SLO", "JPN", "RUS", 
                 "POL", "JPN", "JPN", "CZE", "SLO", "AUT", "CZE", "SUI", "CAN", 
                 "FRA", "NOR", "BUL")
Dist1 <- c(131.5, 131.0, 131.0, 133.5, 128.5, 130.0, 132.5, 128.0, 125.5, 127.0, 126.0,
           128.5, 120.0, 122.0, 122.5, 123.5, 116.0, 126.5, 128.5, 119.0, 120.0, 120.5, 
           118.5, 117.5, 120.0, 117.5, 117.0, 116.5, 124.5, 117.0)
Dist2 <- c(135.5, 130.5, 129.5, 126.5, 129.5, 126.5, 125.5, 129.0, 129.5, 124.0, 125.5, 
           125.5, 128.0, 125.5, 126.0, 122.0, 132.0, 121.0, 121.0, 126.0, 124.0, 120.5, 
           121.0, 122.5, 117.5, 119.0, 118.5, 116.5, 102.0, NA)
Total <- c(279.4, 267.3, 266.1, 262.0, 259.4, 256.1, 250.9, 248.9, 248.7, 245.5, 242.0, 
           240.2, 239.9, 233.7, 230.6, 230.5, 230.0, 229.1, 228.7, 225.7, 221.4, 220.1, 
           219.8, 219.0, 218.2, 212.6, 212.1, 205.9, 185.5, NA)

Dist2[length(Dist2)]=0
Total[length(Total)]=Dist1[length(Dist1)]

MS2019_scores <- data.frame(Name, Nationality, Dist1, Dist2, Total)

write.table(MS2019_scores, "MS2019_scores.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
