Country.instance_eval do
  has_many :states, :order => "name ASC"
end