
-- Understanding what content is available in different countries
-- Identifying similar content by matching text-based features
-- Network analysis of Directors and find interesting insights
-- Does Netflix has more focus on TV Shows than movies in recent years.

select *
from netflix_titles_needs_cleaning4
limit 10000;

-- find duplicates

select *,
 row_number() over(partition by 
 show_id, `type`, title, director,
 country, date_added, release_year,
 rating, duration, listed_in) as row_num
from netflix_titles_needs_cleaning4
limit 10000
;

with cte_dup as (
select *,
 row_number() over(partition by 
 show_id, `type`, title, director,
 country, date_added, release_year,
 rating, duration, listed_in) as row_num
from netflix_titles_needs_cleaning4
limit 10000
)
select *
from cte_dup
where row_num > 1
;

select *,
 row_number() over(partition by 
  `type`, title, director,
 country, date_added, release_year,
 rating, duration, listed_in) as row_num
from netflix_titles_needs_cleaning4
limit 10000
;

with cte_dup as (
select *,
 row_number() over(partition by 
`type`, title, director,
 country, date_added, release_year,
 rating, duration, listed_in) as row_num
from netflix_titles_needs_cleaning4
limit 10000
)
select *
from cte_dup
where row_num > 1
;

-- 15-Aug, 22-Jul, 9-Feb

select *
from netflix_titles_needs_cleaning4
where title = '15-Aug'
;
select *
from netflix_titles_needs_cleaning4
where title = '22-Jul'
;
select *
from netflix_titles_needs_cleaning4
where title = '9-Feb'
;

delete
from netflix_titles_needs_cleaning4
where show_id = 's3963'
;
delete
from netflix_titles_needs_cleaning4
where show_id = 's4523'
;
delete
from netflix_titles_needs_cleaning4
where show_id = 's3997'
;

with cte_dup as (
select *,
 row_number() over(partition by 
`type`, title, director,
 country, date_added, release_year,
 rating, duration, listed_in) as row_num
from netflix_titles_needs_cleaning4
limit 10000
)
select *
from cte_dup
where row_num > 1
;

-- concentrating on the title column for duplicates

select *, row_number() over(partition by title)
from netflix_titles_needs_cleaning4
limit 10000
;

with cte_dup as (
select *, row_number() over(partition by title) as row_num
from netflix_titles_needs_cleaning4
limit 10000
)
select *
from cte_dup
where row_num > 1
;

-- Arès, Death Note, Esperando la carroza, FullMetal Alchemist, Love in a Puff, Sin senos sí hay paraíso, Veronica

select *
from netflix_titles_needs_cleaning4
where title = 'Arès'
;
select *
from netflix_titles_needs_cleaning4
where title = 'Death Note'
;
select *
from netflix_titles_needs_cleaning4
where title = 'Esperando la carroza'
;

delete
from netflix_titles_needs_cleaning4
where show_id = 's6706'
;

select *
from netflix_titles_needs_cleaning4
where title = 'FullMetal Alchemist'
;
select *
from netflix_titles_needs_cleaning4
where title = 'Love in a Puff'
;

delete 
from netflix_titles_needs_cleaning4
where show_id = 's7346'
;

select *
from netflix_titles_needs_cleaning4
where title = 'Sin senos sí hay paraíso'
;

delete 
from netflix_titles_needs_cleaning4
where show_id = 's8023'
;

select *
from netflix_titles_needs_cleaning4
where title = 'Veronica'
;

with cte_dup as (
select *, row_number() over(partition by title) as row_num
from netflix_titles_needs_cleaning4
limit 10000
)
select *
from cte_dup
where row_num > 1
;

select *
from netflix_titles_needs_cleaning4
limit 10000
;

-- find duplicates and standardization

select *
from netflix_titles_needs_cleaning4
order by 1
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 2
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 3
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 4
limit 10000
;

update netflix_titles_needs_cleaning4
set director = null
where director = ''
;

select *
from netflix_titles_needs_cleaning4
order by 5
limit 10000
;

update netflix_titles_needs_cleaning4
set country = null
where country = ''
;

select *
from netflix_titles_needs_cleaning4
order by 6
limit 10000
;

update netflix_titles_needs_cleaning4
set date_added = null
where date_added = ''
;

-- standardize the date_added column

select date_added, replace(date_added, ',', '')
from netflix_titles_needs_cleaning4
where date_added like '%20__'
;

update netflix_titles_needs_cleaning4
set date_added = replace(date_added, ',', '')
where date_added like '%20__'
;

select date_added, str_to_date(date_added, '%M %d %Y')
from netflix_titles_needs_cleaning4
where date_added like '%20__'
;

update netflix_titles_needs_cleaning4
set date_added = str_to_date(date_added, '%M %d %Y')
where date_added like '%20__'
;

alter table netflix_titles_needs_cleaning4
modify column date_added date
;

select *
from netflix_titles_needs_cleaning4
order by 6
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 7
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 8
limit 10000
;

-- 66 min, 74 min, 84 min

update netflix_titles_needs_cleaning4
set rating = null
where rating = ''
;

update netflix_titles_needs_cleaning4
set duration = rating
where rating = '66 min'
;
update netflix_titles_needs_cleaning4
set duration = rating
where rating = '74 min'
;
update netflix_titles_needs_cleaning4
set duration = rating
where rating = '84 min'
;

select *
from netflix_titles_needs_cleaning4
order by 8
limit 10000
;

update netflix_titles_needs_cleaning4
set rating = null
where rating = '66 min'
;
update netflix_titles_needs_cleaning4
set rating = null
where rating = '74 min'
;
update netflix_titles_needs_cleaning4
set rating = null
where rating = '84 min'
;

select *
from netflix_titles_needs_cleaning4
order by 8
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 9
limit 10000
;
select *
from netflix_titles_needs_cleaning4
order by 10
limit 10000
;


--               Understanding what content is available in different countries

select 
title, country,
(length(country) - length(replace(country, ',', ''))) + 1 as NumberOfCountries
from netflix_titles_needs_cleaning4
limit 10000
;

with cte_diff_countries as (
select *,
(length(country) - length(replace(country, ',', ''))) + 1 as NumberOfCountries
from netflix_titles_needs_cleaning4
limit 10000
)
select `type`, title, NumberOfCountries, release_year, year(date_added) as year_added,
case
when release_year <= 1999 then '1925 - 1999'
when release_year <= 2010 then '2000 - 2010'
when release_year <= 2016 then '2011 - 2016'
when release_year <= 2021 then '2017 - 2021'
end as release_year_range,
case
when year(date_added) <= 2014 then '2011 - 2014'
when year(date_added) <= 2018 then '2015 - 2018'
when year(date_added) <= 2021 then '2019 - 2021'
end as year_added_range
from cte_diff_countries
where NumberOfCountries > 1
order by 3 desc
;



--                         Identifying similar content by matching text-based features

select *
from netflix_titles_needs_cleaning4
limit 10000
;

select type, count(type)
from netflix_titles_needs_cleaning4
group by type
;

select count(title) as numberOfMovies
from netflix_titles_needs_cleaning4
where type = 'Movie'
and release_year >= 2020
;

select distinct rating
from netflix_titles_needs_cleaning4
limit 10000
;

select rating, count(title)
from netflix_titles_needs_cleaning4
group by rating
limit 10000
;

select rating, `type`, count(title)
from netflix_titles_needs_cleaning4
group by rating, `type`
limit 10000
;

-- number of titles by rating

select
 rating, `type`,
 year(date_added) as year_added,
 release_year,
 count(title),
case
when year(date_added) <= 2012 then '2008 - 2012'
when year(date_added) <= 2016 then '2013 - 2016'
when year(date_added) <= 2021 then '2017 - 2021'
end as year_added_range,
case
when release_year <= 1999 then '1925 - 1999'
when release_year <= 2010 then '2000 - 2010'
when release_year <= 2016 then '2011 - 2016'
when release_year <= 2021 then '2017 - 2021'
end as release_year_range
from netflix_titles_needs_cleaning4
group by rating, `type`, year_added, release_year,year_added_range
limit 10000
;


--                          Network analysis of Directors and find interesting insights

select *
from netflix_titles_needs_cleaning4
limit 10000
;

select director, country
from netflix_titles_needs_cleaning4
where country = 'United States'
;

select director, country, release_year
from netflix_titles_needs_cleaning4
where country like '%United State%'
and director is not null
limit 10000
;


--                           Does Netflix has more focus on TV Shows than movies in recent years.

select *
from netflix_titles_needs_cleaning4
limit 10000
;

select type, count(title)
from netflix_titles_needs_cleaning4
where release_year >= 2020
group by type
;

select type, count(title)
from netflix_titles_needs_cleaning4
where year(date_added) >= 2020
group by type
;

select 
type, 
count(title),
year(date_added) as year_added,
release_year,
case
when year(date_added) <= 2012 then '2008 - 2012'
when year(date_added) <= 2016 then '2013 - 2016'
when year(date_added) <= 2021 then '2017 - 2021'
end as year_added_range,
case
when release_year <= 1999 then '1925 - 1999'
when release_year <= 2010 then '2000 - 2010'
when release_year <= 2016 then '2011 - 2016'
when release_year <= 2021 then '2017 - 2021'
end as release_year_range
from netflix_titles_needs_cleaning4
group by `type`, year_added_range, release_year_range, year_added, release_year
;










