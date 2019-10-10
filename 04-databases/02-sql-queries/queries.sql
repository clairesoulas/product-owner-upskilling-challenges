---------------------------------------
-- [THE BASICS]
---------------------------------------

-- Get all sites
-- TODO: SELECT ...
SELECT * from sites;

-- Get all sites sorted by name
-- TODO: SELECT ...
select * from sites order by name;

-- Gett all activity names sorted by name
-- TODO: SELECT ...
select name from activities order by name;

-- Get all "Sport" activities
-- TODO: SELECT ...
-- Expected result: 8 rows
select * from activities where category = 'Sport';

-- Get all Escape Games in Nantes
-- TODO: SELECT ...
-- Expected result: 3 rows
select * from activities where lower(name) like "%escape game%" and city="Nantes";

---------------------------------------
-- [AGGREGATES]
---------------------------------------

-- Count all the activities
-- TODO: SELECT ...
-- Expected result: 44
select count(*) from activities;

-- Count all "Adventure" activities
-- TODO: SELECT ...
-- Expected result: 13
select count(*) from activities where category='Adventure';

-- Count the number of activities per category
-- TODO: SELECT ...
select category, count(*) as total from activities group by category;
-- Expected result:
-- category    total
-- ----------  ----------
-- Adventure   13
-- Cultural    6
-- Food        6
-- Sport       8
-- Visits      5
-- Workshops   6

-- Get the 3 category names with the biggest number of activities
-- TODO: SELECT ...
select category, count(*) as total from activities group by category order by total desc limit(3);
-- Expected result:
-- category    total
-- ----------  ----------
-- Adventure   13
-- Sport       8
-- Cultural    6

---------------------------------------
-- [JOINS]
---------------------------------------
-- Get all employee names working from site ile de Nantes sorted by first name
-- TODO: SELECT ...
select employees.first_name, employees.last_name, sites.name from employees inner join sites on sites.id = employees.site_id where lower(sites.name)='ile de nantes' order by first_name asc;
-- Expected result: 53 rows

-- Get all the activity names where you have been to, sorted by name
-- TODO: SELECT ...
-- Expected result: well, it depends on who you are :)

 select activities.name from participations inner join team_building_sessions on participations.team_building_session_id=team_building_session_id
 inner join activities on activities.id = team_building_sessions.activity_id
 inner join employees on employees.id = participations.employee_id
 where participations.employee_id=21 AND employees.first_name="Claire" AND employees.last_name="Soulas";

--select id from employees where employees.first_name="Claire" and employees.last_name = "Soulas";
--select activities.name from participations inner join team_building_sessions on participations.team_building_session_id=team_building_session_id
  -- ...> inner join activities on activities.id = team_building_sessions.activity_id
   --...> where participations.employee_id=21;


-- [NEW KEYWORD] Get all the team names that have done an Adventure activity, sorted by names
-- TODO: SELECT ...
select distinct teams.name from team_building_sessions
  inner join teams on teams.id = team_building_sessions.team_id
  inner join activities on activities.id = team_building_sessions.activity_id
where activities.category = "Adventure"
order by teams.name;
-- Expected result:
-- name
-- --------------------
-- Business Development
-- Product Owner
-- R&D

-- Get the team names and total number of team building sessions done, sorted by top teams
-- TODO: SELECT ...
  select teams.name, count(*) as total_sessions from team_building_sessions
    inner join teams on teams.id = team_building_sessions.team_id
  group by teams.name
  order by total_sessions desc;
-- Expected result:
-- name        total_sessions
-- ----------  --------------
-- R&D         7
-- Marketing   4
-- Business D  3
-- Product Ow  3
-- Finance &   2
-- UI / UX     2
-- Customer S  1

-- Get all the employee names, team names and site names that have never attended a team building session
-- TODO: SELECT ...

select employees.first_name, employees.last_name, teams.name, sites.name from employees
  left outer join teams on employees.team_id = teams.id
  left outer join sites on employees.site_id = sites.id
  left outer join team_building_sessions on teams.id = team_building_sessions.team_id
  left outer join participations on participations.team_building_session_id = team_building_sessions.id
where participations.employee_id IS NULL
  ;
-- Expected result:
-- first_name  last_name   team        site
-- ----------  ----------  ----------  -----------
-- Harmony     Florin      Channels    Paris 13ème
-- Julia       Ivanets     Channels    Paris 13ème
-- Pierre      Pellan      Channels    Paris 13ème

-- [NEW AGGREGATE] Get the budget spent on team building sessions per team, sorted by most expensive to leASt expensive
-- TODO: SELECT ...

-- NOTE : left outer join allows to see if a team has spent nothing :)
-- It adds the Channels 0 row in the results
select teams.name, sum(team_building_sessions.price) as total_price from teams
  left outer join team_building_sessions on teams.id = team_building_sessions.team_id
  group by teams.name
order by total_price desc;

-- Expected result:
-- name          total_price
-- ------------  -----------
-- Finance & RH  1620
-- Business Dev  1446
-- R&D           1140
-- Marketing     445
-- Customer Suc  360
-- Product Owne  267
-- UI / UX       240

-- Get the site names and total number of team building sessions done, sorted by top sites
-- TODO: SELECT ...

select sites.name, count( distinct team_building_sessions.id) as total_sessions from sites
  inner join employees on employees.site_id = sites.id
  inner join participations on participations.employee_id = employees.id
  inner join team_building_sessions on team_building_sessions.id = participations.team_building_session_id
group by sites.name
order by total_sessions desc;
-- Expected result:
-- name           total_sessions
-- -------------  --------------
-- Ile de Nantes  12
-- Paris 13ème    10
