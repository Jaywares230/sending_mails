
require "google_drive"
require 'rubygems'
require 'open-uri'
require 'nokogiri'



def open_link_townhalls (link)
  #first of all we are defining our array where all the informations about the townhalls will be stored in 

  listarray = []
 
 #then we open the page that we want to scrap
 
  page_origin = Nokogiri::HTML(open(link))

 #after that because this page has on it a bunch of towhalls links where all the informations that we want are we are selecting those links

  mairie_link = page_origin.xpath('//p/a')
 # then itering on each one
  mairie_link.each {|balise|

 #we are making the link of each pages by putting together the base of the link and the href id 
  lien_mairie = "http://annuaire-des-mairies.com" + balise['href']
 # this puts is just there to know where your programm is 
  puts lien_mairie
 # we open each link 
  mairie_page = Nokogiri::HTML(open(lien_mairie))
 #we are selecting the name 
  mairie_name = mairie_page.xpath("/html/body/div/header/section/div/div[1]/h1/small").text 
 #we are selecting the email 
  
  mairie_email = mairie_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
 #we are selecting the adress

  mairie_code = mairie_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[1]/td[2]").text
 # then we are creating a Hash 
  list = Hash[:name => mairie_name, :email => mairie_email, :postal => mairie_code]
 #But in order to iterate on the information that we did get on each townhalls we have to put each hash in an array so we push it into the array listarray
  listarray.push(list)


}
#This puts is also to keep an eye on where is your programm and if all the datas are well scrapped
puts listarray
# we connect ourselves to a google session with the config.json that u have to fill up with your API keys 
  session = GoogleDrive::Session.from_config("config.json")
# then we open the spreadsheet with it's key to get the first french department that we want to scrap here it's haute vienne
  mairies = session.spreadsheet_by_key("1zmXk-c_7KSmlrmRpET96F1lUeqRzkuHcVtLW7ukMLVI").worksheets[0]
  # the key of loire atlantique "1GS7WWhw9J_kMoxoMQmsB-Bf71Gw9-_6-byFFFmuFwaQ" and of martinique "1hfQXd0-qhSl6vpRtGlcseHGnSKmwpJHr0bt8Vprybxk"
  #we define the first three columns with a name Mairie, Email, Adresse
  
  mairies[1, 1] = "Mairie"
  mairies[1, 2] = "Email"
  mairies[1, 3] = "Adresse"
  #We are saving it in order to see the results on our spreadsheet when the programm is over

mairies.save
#we define i to be equal to 2 because on line one there's the name of our three columns and we don't want them to be erased
i = 2
#but what we want is to store on a line the datas so i =2 for the first loop then 3 and so on so that no lines are erased 
 listarray.each{ |x|

  mairies[i, 1] = x[:name]
  mairies[i, 2] = x[:email]
  mairies[i, 3] = x[:postal]
  mairies.save
  i += 1
  }
end 


def perform
  #while changing the id of the spreadsheet you also have to change the url because this one is only for the Haute vienne department
  # thats the  loire atlantique one : "http://www.annuaire-des-mairies.com/loire-atlantique.html" , for martinique: "http://www.annuaire-des-mairies.com/martinique.html"
  url_origin = "http://www.annuaire-des-mairies.com/haute-vienne.html"
  open_link_townhalls(url_origin)
end

#And finally we just run the programm ;) 
perform




