CREATE TABLE covadeaths (iso_code varchar(255),
    continent varchar(255),
    location varchar(255),
    dates date,
	population int,
	total_cases int,
    new_cases int,
    new_cases_smoothed int,
    total_deaths int,
    new_deaths int,
    new_deaths_smoothed int,
    total_cases_per_million int,
    new_cases_per_million int,
    new_cases_smoothed_per_million int,
    total_deaths_per_million int,
    new_deaths_per_million int,
    new_deaths_smoothed_per_million int,
    reproduction_rate int,
    icu_patients int,
    icu_patients_per_million int,
    hosp_patients int,
    hosp_patients_per_million int,
    weekly_icu_admissions int,
    weekly_icu_admissions_per_million int,
    weekly_hosp_admissions int,
    weekly_hosp_admissions_per_million int);


ALTER TABLE covadeaths modify population bigint;

LOAD DATA INFILE 'covidDeathsdata.csv' INTO TABLE covadeaths 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT *
FROM covadeaths;

select * from covidvaccinations;

SHOW VARIABLES LIKE "secure_file_priv";

select location,dates,total_cases,new_cases,total_deaths,population from covadeaths order by 1,2;

select location,dates,total_cases,total_deaths,population, (total_deaths/total_cases)*100 as Death_Percentage_of_infected
 from covadeaths 
 where location = "India"
 order by 1,2
 ;

/* Countries with highest infecton rate compared to population --->*/ 

select location,population,MAX(total_cases),max(total_cases/population)*100 as Total_infected_Percentage_of_population
 from covadeaths 
 where continent is not null
 group by location,population
 order by 4 desc
 ;
 
 /* Countries with highest death rate compared to population --->*/ 
 select location ,MAX(total_deaths),max(total_deaths/population)*100 as Total_death_Percentage_of_population
 from covadeaths 
 where continent <> ""
 group by location
 order by 3 desc 
 ;

 /* Continents with highest death rate compared to population --->*/ 
 select continent,MAX(total_deaths),max(total_deaths/population)*100 as Total_death_Percentage_of_population
 from covadeaths 
 where continent <> ""
 group by continent
 order by 3 desc 
 ;
 
 select * from covadeaths dea join covidvaccinations vac on dea.dates = vac.date and dea.location = vac.location; 
 
 
  /* Countries with their vaccinaton status across several dates --->*/ 
  select dea.continent,dea.location,dea.dates,vac.new_vaccinations,sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.dates) as RollingPeopleVaccinated
  from covadeaths dea join covidvaccinations vac on dea.dates = vac.date and dea.location = vac.location
  where dea.continent <> ""
  order by 2,3
  ; 
  
  /*Percentage of population vaccinated in each country using CTE*/
  
  with PopvsVac (Continent,Location,Date,Population,New_Vaccinations,RollingVaccinated) as
 (
 select dea.continent,dea.location,dea.dates,dea.population ,vac.new_vaccinations,sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.dates) as RollingPeopleVaccinated
  from covadeaths dea join covidvaccinations vac on dea.dates = vac.date and dea.location = vac.location
  where dea.continent <> ""
 )
 select *, (RollingVaccinated/Population)*100 from PopvsVac;
 
 
   select *
  from covadeaths dea join covidvaccinations vac on dea.dates = vac.date and dea.location = vac.location
  where dea.continent <> ""
  order by 2,3
  ; 
  
  /*Creating View to store data for later visualizations*/
  create view PercentPopulationVaccinated  as 
  (
  select dea.continent,dea.location,dea.dates,dea.population ,vac.new_vaccinations,sum(vac.new_vaccinations) over (partition by dea.location order by dea.location,dea.dates) as RollingPeopleVaccinated
  from covadeaths dea join covidvaccinations vac on dea.dates = vac.date and dea.location = vac.location
  where dea.continent <> ""
  )