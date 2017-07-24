require 'pry'

require_relative '../models/animal'
require_relative '../models/owner'
require_relative '../models/cat_details'

# CatDetails.delete_all
# Animal.delete_all
# Owner.delete_all

owner1 = Owner.new ({
  'name' => 'SHELTER'
})
owner1.save

owner2 = Owner.new ({
  'name' => 'Stuart'
})
owner2.save

owner3 = Owner.new ({
  'name' => 'Alex'
})
owner3.save

# The Shelter needs to be the first owner.
animal1 = Animal.new ({
  'name' => 'Treacle',
  'type' => 'cat',
  'gender' => 'female',
  'age' => 12,
  'breed' => 'Siamese',
  'admission_date' => '01/02/15',
  'adoptable' => true,
  'summary' => 'The quick brown fox jumps over the lazy dog.',
  'owner_id' => owner2.id
})
animal1.save

animal2 = Animal.new ({
  'name' => 'Peanut',
  'type' => 'cat',
  'gender' => 'male',
  'age' => 5,
  'breed' => 'Fifer',
  'admission_date' => '03/04/16',
  'adoptable' => true,
  'summary' => 'The rain in Spain falls mainly on the plain.',
  'owner_id' => owner3.id
})
animal2.save

animal3 = Animal.new ({
  'name' => 'Honey',
  'type' => 'cat',
  'gender' => 'female',
  'age' => 17,
  'breed' => 'Other',
  'admission_date' => '05/06/17',
  'adoptable' => false,
  'summary' => 'All work and no play makes Jack a dull boy.',
  'owner_id' => owner1.id
})
animal3.save

animal4 = Animal.new ({
  'name' => 'Poppy',
  'type' => 'dog',
  'gender' => 'male',
  'age' => 3,
  'breed' => 'Chihuahua',
  'admission_date' => '07/08/15',
  'adoptable' => true,
  'summary' => 'Pack my box with five dozen liquor jugs.',
  'owner_id' => owner2.id
})
animal4.save

animal5 = Animal.new ({
  'name' => 'Daisy',
  'type' => 'dog',
  'gender' => 'female',
  'age' => 7,
  'breed' => 'Staffordshire Bull Terrier',
  'admission_date' => '09/10/16',
  'adoptable' => false,
  'summary' => 'Sphinx of black quartz, judge my vow.',
  'owner_id' => owner1.id
})
animal5.save

cat_details1 = CatDetails.new ({
  'colour' => 'black',
  'live_with_cats' => true,
  'live_with_dogs' => false,
  'live_with_family' => true,
  'indoor_cat' => false,
  'cat_id' => animal1.id
})
cat_details1.save

cat_details2 = CatDetails.new ({
  'colour' => 'grey and white',
  'live_with_cats' => true,
  'live_with_dogs' => true,
  'live_with_family' => false,
  'indoor_cat' => true,
  'cat_id' => animal2.id
})
cat_details2.save

cat_details3 = CatDetails.new ({
  'colour' => 'tortoiseshell',
  'live_with_cats' => false,
  'live_with_dogs' => false,
  'live_with_family' => true,
  'indoor_cat' => true,
  'cat_id' => animal3.id
})
cat_details3.save

binding.pry
nil