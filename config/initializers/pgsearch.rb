PgSearch.multisearch_options = {
  :using => {
    tsearch:    {dictionary: 'english'},
    trigram:    {threshold:  0.05},
    dmetaphone: {}
  },
  :ignoring => :accents
}
# PgSearch.multisearch_options = {
#     using: {
#                     }
# }
