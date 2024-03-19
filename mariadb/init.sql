CREATE USER 'wikiuser'@'localhost' IDENTIFIED BY 'dmhqbGtpdW5odQo=';
CREATE DATABASE mediawikidb;
GRANT ALL PRIVILEGES ON mediawikidb.* TO 'wikiuser'@'localhost';
FLUSH PRIVILEGES;
