xquery version "3.0";

import module namespace jx = "http://zorba.io/modules/json-xml";
import module namespace transform = "transform" at "transform.xq";
import module namespace tags = "tags" at "tags.xq";

declare variable $doc external;
declare variable $version external;

jx:xml-to-json(
  <json type="object">
    <pair name="version" type="string"> { $version } </pair>
    { transform:extract-date($doc) }
    { transform:extract-revisions($doc) }
    { $tags:tags }
    <pair name="words" type="array">
      { for $word in $doc/JMdict/entry
        where transform:is-common($word/k_ele/ke_pri) or transform:is-common($word/r_ele/re_pri)
        return transform:word($word) }
    </pair>
  </json>
)
