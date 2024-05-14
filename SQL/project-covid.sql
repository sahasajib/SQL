CREATE DATABASE covid;
USE covid;

SELECT *
FROM CovidVaccinations
WHERE continent is not null
order by 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
order by 1,2;

-- Locking at total cases vs total deaths --

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%Bangladesh%'
order by 1,2;

-- locking at total cases vs populations --

SELECT location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%Bangladesh%'
order by 1,2;

-- locking at countries with highest infection rate compared to populations --
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM CovidDeaths
group by location, population
order by 1,2;

-- showing countries with highest death count per populations --

SELECT location, MAX(total_deaths) as TotalDeathCount
FROM CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
group by location
order by TotalDeathCount desc;

-- showing   continent with highest death count  --

SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null

group by continent
order by TotalDeathCount desc;

-- global numbers
 
 
SELECT  SUM(new_cases), SUM(new_deaths), SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage-- , total_deaths, (total_cases/population)*100 as DeathPercentage
FROM CovidDeaths
WHERE continent is not null
-- group by date
order by 1,2;

--  locking at total population vs vaccination
 -- Use cte

WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by 
dea.location,dea.date) as RollingPeopleVaccinated
FROM CovidDeaths dea
join CovidVaccinations vac
	ON dea.location = vac.location
    and dea.date =vac.date
WHERE dea.continent is not null
-- AND location like '%Bangladesh%'
-- order by 2,3
)
SELECT * , (RollingPeopleVaccinated/population)*100 as per
FROM PopvsVac;

-- temp table
DROP TABLE if exists PercentPopulationVaccinated;
CREATE TABLE PercentPopulationVaccinated(
Continent VARCHAR(55),
Location VARCHAR(255),
Date datetime,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
);
INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by 
dea.location,dea.date) as RollingPeopleVaccinated
FROM CovidDeaths dea
join CovidVaccinations vac
	ON dea.location = vac.location
    and dea.date =vac.date;
-- WHERE dea.continent is not null;
-- AND location like '%Bangladesh%'
-- order by 2,3

SELECT *, (RollingPeopleVaccinated/population)*100 as par
FROM PercentPopulationVaccinated;
CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by 
dea.location,dea.date) as RollingPeopleVaccinated
FROM CovidDeaths dea
join CovidVaccinations vac
	ON dea.location = vac.location
    and dea.date =vac.date
WHERE dea.continent is not null;
-- AND location like '%Bangladesh%'
-- order by 2,3

SELECT * 
FROM PercentPopulationVaccinated