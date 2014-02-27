{-# LANGUAGE OverloadedStrings #-}

import Workbench.HTTP

import Data.Aeson

url = "http://solr02.timeout.com:8080/solr/uk_en/select?q=&start=0&rows=50&fq=%7B%21tag%3Dtype%7Dtype%3Avenue+OR+type%3Aevent&fq=node_id%3A4695&fq=node_id%3A4695&fq=site_tag_s%3Auk-london+OR+site_tag_s%3A%22%22&sort=popularity_i+desc%2Cscore+desc%2Csort_name+asc%2Cpopularity_i+desc%2Cscore+desc%2Csort_name+asc&spellcheck=true&spellcheck.count=5&spellcheck.collate=true&spellcheck.accuracy=0.6&spellcheck.extendedResults=true&spellcheck.collateExtendedResults=true&spellcheck.maxCollations=1&spellcheck.maxCollationTries=5&facet=true&facet.missing=true&facet.mincount=1&facet.field=%7B%21ex%3Da_z%7Da_z&facet.field=%7B%21ex%3Dtype%7Dtype&facet.field=%7B%21key%3Drequest_facet.default.flags_facet%7Dflags_facet&facet.field=%7B%21key%3Drequest_facet.default.star_ratings_facet%7Dstar_ratings_facet&facet.field=%7B%21key%3Drequest_facet.default.subject_facet%7Dsubject_facet&facet.field=%7B%21key%3Drequest_facet.default.venue_type_facet%7Dvenue_type_facet&facet.range=%7B%21key%3Dfacet_range.default.occurrence_dates%7Doccurrence_dates&f.occurrence_dates.facet.range.start=2014-02-27T00%3A00%3A00Z&f.occurrence_dates.facet.range.end=2014-03-13T23%3A59%3A59Z&f.occurrence_dates.facet.range.gap=%2B1DAY&f.occurrence_dates.facet.range.other=all&defType=dismax&q.alt=*%3A*&bf=linear%28editorial_rating_i%2C20%2C-60%29&bf=product%28popularity_norm_d%2C2%29&bf=sub%28product%28product%28div%28ratings_count_i%2Csum%2810%2Cratings_count_i%29%29%2Cuser_rating_i%29%2C14%29%2C30%29&bq=%28%28node_id%3A783+AND+NOT%28editorial_rating_i%3A%5B*+TO+*%5D%29%29%5E10%29&bq=node_id%3A785%5E5&bq=node_id%3A786%5E4&bq=node_id%3A784%5E4&bq=node_id%3A3411%5E4&bq=node_id%3A4695%5E5&bq=%28node_id%3A108+AND+NOT%28node_id%3A783+OR+editorial_rating_i%3A%5B*+TO+*%5D%29%29%5E8&bq=%28%28type%3Aevent+OR+%28type%3Afilm+AND+release_date_tdt%3A%5BNOW%2FDAY-60DAY+TO+NOW%2FDAY%2B7DAY%5D%29%29+AND+occurrence_dates%3A%5BNOW%2FDAY+TO+NOW%2FDAY%2B7DAY%5D%29%5E10+OR+type%3Avenue%5E5&qf=search_names%5E25&qf=tag_name%5E50&qf=primary_tag_representation%5E20&qf=indexed_annotation%5E2&pf=search_names%5E25&pf=primary_tag_representation%5E50&tie=0.1&qs=50&wt=json&version=2"

main :: IO ()
main = do
  value <- getUrlAsJson url
  putStrLn $ either show (show . f) value
    where
      f :: Value -> String
      f value = do
        response <-value .: "response"
        return response
{--
import qualified Workbench.JSON as JSON
import qualified Workbench.File as File

import Data.Aeson (Value(Bool))
import Data.HashMap.Strict (insert)

main :: IO ()
main = File.transformByLines (JSON.transformObject f) "/home/alois/jvm/persist/src/test/resources/com/timeout/persist/data/platform/venues.json"
  where
    f = insert "sponsored" (Bool False)
    --}
