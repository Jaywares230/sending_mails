require 'rubygems'
require 'google_drive'
require 'gmail'
require 'mail'

session = GoogleDrive::Session.from_config("config.json")
hv = session.spreadsheet_by_key("1zmXk-c_7KSmlrmRpET96F1lUeqRzkuHcVtLW7ukMLVI").worksheets[0]
martinique = session.spreadsheet_by_key("1hfQXd0-qhSl6vpRtGlcseHGnSKmwpJHr0bt8Vprybxk").worksheets[1]
loire = session.spreadsheet_by_key("1GS7WWhw9J_kMoxoMQmsB-Bf71Gw9-_6-byFFFmuFwaQ").worksheets[2]


def townhalls_mailer(spreadsheet_by_key)
    
email = ""
ville = ""


spreadsheet_by_key.rows.each do |row|

ville = "#{row[0]}"
email = "#{row[1]}"

gmail = Gmail.connect("Sarah.pellencore@gmail.com", "Jeparsdechezmoi95")
    	email = gmail.compose do
  to "#{email}"
  subject "La formation de The Hacking Project c'est l'avenir !"
  body "Bonjour,
nous sommes des élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{ville} veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
end 
end
email.deliver!
gmail.logout

end 
end

townhalls_mailer(hv)










