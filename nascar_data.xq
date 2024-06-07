declare variable $param1 as xs:string external;
declare variable $param2 as xs:string external;
<resulT>
    <parametro1>{$param1}</parametro1>
    <parametro2>{$param2}</parametro2>
    <nascar_data>
        <year>{doc('drivers_standings_edited.xml')/series/season/@year}</year>
        <serie_type>{doc('drivers_standings_edited.xml')/series/@name}</serie_type>
  </nascar_data>
</resulT>

