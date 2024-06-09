declare namespace ns1 = "http://feed.elasticstats.com/schema/nascar/series-v2.0.xsd";
declare namespace ns2 = "http://feed.elasticstats.com/schema/nascar/statistics-v3.0.xsd";

declare variable $param1 as xs:string external;
declare variable $param2 as xs:string external;

let $doc1 := doc(concat($param1 , "/" , $param2 , "/driver_list.xml"))//ns1:driver
let $doc2 := doc(concat($param1 , "/" , $param2 , "/driver_standings.xml"))

return 
    <resulT>
        <year>{$param2}</year>
        <serie_type>{data($doc2/ns2:series/@name)}</serie_type>
        <drivers>{
            for $driver in ($doc1)
            order by $driver/@full_name
            return 
            <driver>
                <full_name>{data($driver/@full_name)}</full_name>
                <country>{data($driver/@country)}</country>
                <birth_date>{data($driver/@birth_date)}</birth_date>
                <birth_place>{data($driver/@birth_place)}</birth_place>
                <rank>{data($doc2//ns2:driver[@id = data($driver/@id)]/@id)}</rank>
                
                {if (exists($driver/ns1:car))
                then <car>{data($driver/ns1:car/ns1:manufacturer/@name)}</car>
                else ()
                }
                <statics>
                    
                </statics>
            </driver>
        }
        </drivers>
    </resulT>

