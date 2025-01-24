use high_cloud;


alter table 
 high_cloud_airlines rename column `Transported Passengers` to transported_passengers;
 
 alter table
 high_cloud_airlines rename column `Available Seats` to available_seats;
 
 SELECT SUM(transported_passengers) FROM high_cloud_airlines;
 
 SELECT SUM(available_seats) FROM high_cloud_airlines;
 
 SELECT SUM(Distance) FROM high_cloud_airlines;
 
#KPI_2 Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)
 Select `Year2`,`Quarter`,`Month name` , SUM(transported_passengers), sum(available_seats) ,
 CONCAT( ROUND((Sum(available_seats) / (Select sum(available_seats)from high_cloud_airlines) *100),2),"%") as `Total Available Seats per year`
 from  high_cloud_airlines
 group by `Year2`,`Quarter`,`Month name` order by `Year2` ;


#KPI_3 Find the load Factor percentage on a Carrier Name basis ( Transported passengers / Available seats)
 select DISTINCT `Unique Carrier` , Concat(round(ifnull( ( Sum(transported_passengers)/(sum(transported_passengers) + sum(available_seats)) *100),0),2),"%") 
 as Travelled_Passengers,
 Concat(round(Ifnull((Sum(available_seats)/(sum(transported_passengers) + sum(available_seats)) *100),0),2),"%") as Available_Seats
  from high_cloud_airlines WHERE transported_passengers IS NOT NULL AND available_seats IS NOT NULL
 group by `Unique Carrier`;
 
  select DISTINCT `Unique Carrier` , Concat(round(ifnull( ( Sum(transported_passengers)/( sum(available_seats)) *100),0),2),"%") as `Load Factor`
from high_cloud_airlines WHERE transported_passengers IS NOT NULL AND available_seats IS NOT NULL
 group by `Unique Carrier` order by `Load Factor` desc ;
 
 #KPI_4 Identify Top 10 Carrier Names based passengers preference 
 select `carrier name`, sum(transported_passengers) from high_cloud_airlines group by `carrier name` order by sum(transported_passengers) desc limit 10 ;
 
 #KPI_5 Display top Routes ( from-to City) based on Number of Flights 
  SELECT `From - To City`, COUNT(`%Airline ID`) AS `Number of Flights` FROM  high_cloud_airlines
  group by `From - To City`ORDER BY COUNT(`%Airline ID`) DESC LIMIT 10;
  
  #KPI_6 Identify the how much load factor is occupied on Weekend vs Weekdays
   SELECT 
    CONCAT(ROUND((COUNT(CASE WHEN `Weekday And Weekend` = 'Weekday' THEN 1 END) / COUNT(*) * 100),2),"%") AS Weekday_Percentage,
    CONCAT(ROUND((COUNT(CASE WHEN `Weekday And Weekend` = 'Weekend' THEN 1 END) / COUNT(*) * 100),2),"%") AS Weekend_Percentage
FROM high_cloud_airlines;

 #KPI_7_Identify number of flights based on Distance group## XX
 select  distinct  `Distance Interval`, count(`%Airline ID`) from high_cloud_airlines
 right join distance_group on
 high_cloud_airlines.`%Distance Group ID` = distance_group.distance_group_ID
group by `Distance Interval`;
   
  
 