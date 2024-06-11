declare namespace ns1 = "http://feed.elasticstats.com/schema/nascar/series-v2.0.xsd";
declare namespace ns2 = "http://feed.elasticstats.com/schema/nascar/standings-v2.0.xsd";

declare variable $param1 as xs:string external;
declare variable $param2 as xs:string external;

declare option saxon:output "indent=yes";

let $doc1 := doc(concat($param1 , "/" , $param2 , "/driver_list.xml"))//ns1:driver
let $doc2 := doc(concat($param1 , "/" , $param2 , "/driver_standings.xml"))//ns2:driver



return
if (exists($doc1) and exists($doc2)) then
    <nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">
        <year>{$param2}</year>
        <serie_type>{data(doc(concat($param1 , "/" , $param2 , "/driver_standings.xml"))//ns2:series/@name)}</serie_type>
        <drivers>{
            for $driver in ($doc2)
            order by xs:integer($driver/@rank)
            return 
            <driver>
                <full_name>{data($driver/@full_name)}</full_name>
                <country>{data($doc1[@id = $driver/@id]/@country)}</country>
                <birth_date>{data($doc1[@id = $driver/@id]/@birthday)}</birth_date>
                <birth_place>{data($doc1[@id = $driver/@id]/@birth_place)}</birth_place>
                <rank>{data($driver/@rank)}</rank>
                
                {if (exists($doc1[@id = $driver/@id]/ns1:car))
                then <car>{data($doc1[@id = $driver/@id]/ns1:car[1]/ns1:manufacturer/@name)}</car>
                else ()
                }
                <statistics>
                    <season_points>{data($driver/@points)}</season_points>
                    <wins>{data($driver/@wins)}</wins>
                    <poles>{data($driver/@poles)}</poles>
                    <races_not_finished>{data($driver/@dnf)}</races_not_finished>
                    <laps_completed>{data($driver/@laps_completed)}</laps_completed>
                </statistics>
            </driver>
        }
        </drivers>
    </nascar_data>
else
    <error>Error</error>
