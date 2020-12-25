# == Schema Information
#
# Table name: livestream_stats
#
#  id         :bigint           not null, primary key
#  data       :jsonb
#  end_time   :datetime
#  start_time :datetime
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LivestreamStat < ApplicationRecord
end
