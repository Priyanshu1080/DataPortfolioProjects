CREATE TABLE world_renewable_energy(iso_code varchar(255),
    country varchar(255),
    year int,
    population bigint,
    gdp bigint,
    	energy_cons_change_pct decimal(9,3),
        energy_cons_change_twh decimal(9,3),	
        biofuel_share_elec decimal(9,3),
        biofuel_elec_per_capita	decimal(9,3), 
        biofuel_cons_change_pct decimal(9,3),
        biofuel_share_energy decimal(9,3),
        biofuel_cons_change_twh	decimal(9,3),
        biofuel_consumption decimal(9,3),
        biofuel_cons_per_capita	decimal(9,3),
        electricity_generation decimal(9,3),
        biofuel_electricity decimal(9,3),	
        hydro_electricity decimal(9,3),	
        other_renewable_electricity decimal(9,3),
        other_renewable_exc_biofuel_electricity  decimal(9,3),
        renewables_electricity  decimal(9,3),
        solar_electricity  decimal(9,3),
        wind_electricity decimal(9,3),
        energy_per_gdp	 decimal(9,3),
        energy_per_capita decimal(9,3),
        hydro_share_elec  decimal(9,3),
        hydro_cons_change_pct  decimal(9,3),
        hydro_share_energy  decimal(9,3),
        hydro_cons_change_twh  decimal(9,3),
        hydro_consumption  decimal(9,3),
        hydro_elec_per_capita  decimal(9,3),
        other_renewables_elec_per_capita  decimal(9,3),
        other_renewables_share_elec  decimal(9,3),
        other_renewables_cons_change_pct decimal(9,3),
        other_renewables_share_energy  decimal(9,3),
        other_renewables_cons_change_twh  decimal(9,3),
        other_renewable_consumption decimal(9,3),
        other_renewables_energy_per_capita  decimal(9,3),
        per_capita_electricity decimal(9,3),
        primary_energy_consumption  decimal(9,3),
        renewables_elec_per_capita  decimal(9,3),
        renewables_share_elec  decimal(9,3),
        renewables_cons_change_pct  decimal(9,3),
        renewables_share_energy  decimal(9,3),
        renewables_cons_change_twh decimal(9,3),
        renewables_consumption decimal(9,3),
        renewables_energy_per_capita  decimal(9,3),
        solar_share_elec  decimal(9,3),
        solar_cons_change_pct  decimal(9,3),
        solar_share_energy  decimal(9,3),	
        solar_cons_change_twh  decimal(9,3),
        solar_consumption  decimal(9,3),
        solar_elec_per_capita  decimal(9,3),
        solar_energy_per_capita  decimal(9,3),
        wind_share_elec  decimal(9,3),
        wind_cons_change_pct  decimal(9,3),
        wind_share_energy  decimal(9,3),
        wind_cons_change_twh decimal(9,3),
        wind_consumption decimal(9,3),
        wind_elec_per_capita  decimal(9,3),
        wind_energy_per_capita  decimal(9,3)
);



LOAD DATA INFILE 'world_renewable_energy.csv' INTO TABLE world_renewable_energy 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

ALTER TABLE world_renewable_energy modify energy_per_capita decimal(15,3);




/*Top 20 Countries wiith their per capita energy consumption from renewables,as of 2019 (kilowatt-hours)  */
select country,renewables_energy_per_capita AS "Per capita electricity consumption from renewables,as of 2019 (kilowatt-hours)"
,(gdp/population) as "GDP per capita (USD)"
from world_renewable_energy where iso_code <> "" 
AND year = 2016 order by renewables_energy_per_capita DESC limit 20;

/*Per capita total energy and energy from renewables of countries between 1970 and 2019*/
select country,year,energy_per_capita AS "Energy per capita (kWh)"
,renewables_energy_per_capita AS "Per capita energy consumption from renewables (kWh)"
 from world_renewable_energy where year between 1970 and 2019 order by renewables_energy_per_capita desc;
 
 /*Distibution of different renewable energies */
 select country,year,wind_elec_per_capita, hydro_elec_per_capita,solar_elec_per_capita,biofuel_elec_per_capita
 from world_renewable_energy  where year between 2000 and 2019;
 
 CREATE TABLE world_nonrenewable_energy(
 iso_code varchar(255),
 country varchar(255),	
 year int,
 population bigint,
 gdp bigint,
 coal_prod_change_pct decimal(15,3),
 coal_prod_change_twh decimal(15,3),
 gas_prod_change_pct decimal(15,3),
 gas_prod_change_twh decimal(15,3),
 oil_prod_change_pct decimal(15,3),
 oil_prod_change_twh decimal(15,3),
 energy_cons_change_pct	 decimal(15,3),
 energy_cons_change_twh decimal(15,3),
 carbon_intensity_elec  decimal(15,3),
 coal_share_elec decimal(15,3),
 coal_cons_change_pct decimal(15,3),
 coal_share_energy decimal(15,3),
 coal_cons_change_twh decimal(15,3),
 coal_consumption decimal(15,3),
 coal_elec_per_capita decimal(15,3),
 coal_cons_per_capita decimal(15,3),
 coal_production decimal(15,3),
 coal_prod_per_capita decimal(15,3),
 electricity_generation decimal(15,3),
 coal_electricity decimal(15,3),
 fossil_electricity decimal(15,3),
 gas_electricity decimal(15,3),
 nuclear_electricity decimal(15,3),
 oil_electricity decimal(15,3),
 energy_per_gdp decimal(15,3),
 energy_per_capita decimal(15,3),
 fossil_cons_change_pct decimal(15,3),
 fossil_share_energy decimal(15,3),
 fossil_cons_change_twh decimal(15,3),
 fossil_fuel_consumption decimal(15,3),
 fossil_energy_per_capita decimal(15,3),
 fossil_cons_per_capita decimal(15,3),
 fossil_share_elec decimal(15,3),
 gas_share_elec decimal(15,3),
 gas_cons_change_pct decimal(15,3),
 gas_share_energy decimal(15,3),
 gas_cons_change_twh decimal(15,3),
 gas_consumption decimal(15,3),
 gas_elec_per_capita decimal(15,3),
 gas_energy_per_capita decimal(15,3),
 gas_production decimal(15,3),
 gas_prod_per_capita decimal(15,3),
 low_carbon_share_elec decimal(15,3),
 low_carbon_electricity decimal(15,3),
 low_carbon_elec_per_capita decimal(15,3),
 low_carbon_cons_change_pct decimal(15,3),
 low_carbon_share_energy decimal(15,3),
 low_carbon_cons_change_twh decimal(15,3),
 low_carbon_consumption decimal(15,3),
 low_carbon_energy_per_capita decimal(15,3),
 nuclear_share_elec decimal(15,3),
 nuclear_cons_change_pct decimal(15,3),
 nuclear_share_energy decimal(15,3),
 nuclear_cons_change_twh decimal(15,3),
 nuclear_consumption decimal(15,3),
 nuclear_elec_per_capita decimal(15,3),
 nuclear_energy_per_capita decimal(15,3),
 oil_share_elec decimal(15,3),
 oil_cons_change_pct decimal(15,3),
 oil_share_energy decimal(15,3),
 oil_cons_change_twh decimal(15,3),
 oil_consumption decimal(15,3),
 oil_elec_per_capita decimal(15,3),
 oil_energy_per_capita decimal(15,3),
 oil_production decimal(15,3),
 oil_prod_per_capita decimal(15,3),
 per_capita_electricity decimal(15,3),
 primary_energy_consumption decimal(15,3)
 );
 
LOAD DATA INFILE 'wnrec.csv' INTO TABLE world_nonrenewable_energy 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

ALTER TABLE world_nonrenewable_energy modify gas_prod_change_pct double;

select * from world_nonrenewable_energy;

/*Top 10 countries who have highest fossil fuel energy consumption per capita in 2019 (kwH)*/
select country,fossil_energy_per_capita as "fossil_energy_per_capita (kWH)" from world_nonrenewable_energy
where year=2019 order by energy_per_capita desc
limit 10;


 /*Comparison on renewable and non renewable energy sources used by G-20 countries (KWH) (2016) */
 select distinct wnre.country,wnre.gdp,wnre.fossil_energy_per_capita,wnre.coal_cons_per_capita,wnre.nuclear_energy_per_capita,
(wnre.fossil_energy_per_capita+wnre.coal_cons_per_capita+wnre.nuclear_energy_per_capita) as Total_nonrenewable_energy_per_capita,
wre.solar_energy_per_capita,wre.wind_energy_per_capita,wre.biofuel_cons_per_capita,
(wre.solar_energy_per_capita+wre.hydro_elec_per_capita +wre.wind_energy_per_capita+wre.biofuel_cons_per_capita)  as Total_renewable_energy_per_capita_excluding_hydro
 from world_renewable_energy wre join world_nonrenewable_energy wnre on wre.iso_code=wnre.iso_code and wre.year = wnre.year 
 where wnre.year=2016
 and wnre.iso_code<>"" and wnre.iso_code<>"OWID_WRL" 
 order by wnre.gdp desc limit 20;
 
 /*Top 10 coal-based energy producers*/
 select country,coal_production as "Total Coal produced in (TWH)" from world_nonrenewable_energy where year = 2016
 and iso_code<>"" and iso_code<>"OWID_WRL" 
 order by coal_production desc limit 10;
 
  /*Top 15 oil-based energy producers*/
 select country,oil_production as "Total Oil produced in (TWH)" from world_nonrenewable_energy where year = 2016
 and iso_code<>"" and iso_code<>"OWID_WRL" 
 order by oil_production desc limit 15;