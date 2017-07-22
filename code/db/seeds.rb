require 'pry'

require_relative '../models/animal'
require_relative '../models/owner'

# Create owners.

owner1 = Owner.new ({
  'name' => 'Stuart',
})
owner1.save

owner2 = Owner.new ({
  'name' => 'Alex'
})
owner2.save

# Create animals.

animal1 = Animal.new ({
  'name' => 'Treacle',
  'type' => 'cat',
  'admission_date' => '01/02/15',
  'adoptable' => true,
  'owner_id' => 1
})
animal1.save

animal2 = Animal.new ({
  'name' => 'Peanut',
  'type' => 'cat',
  'admission_date' => '03/04/16',
  'adoptable' => true,
  'owner_id' => 2
})
animal2.save

animal3 = Animal.new ({
  'name' => 'Honey',
  'type' => 'cat',
  'admission_date' => '05/06/17',
  'adoptable' => false,
  'owner_id' => nil
})
animal3.save

animal4 = Animal.new ({
  'name' => 'Poppy',
  'type' => 'dog',
  'admission_date' => '07/08/15',
  'adoptable' => true,
  'owner_id' => 1
})
animal4.save

animal5 = Animal.new ({
  'name' => 'Daisy',
  'type' => 'dog',
  'admission_date' => '09/10/16',
  'adoptable' => false,
  'owner_id' => nil
})
animal5.save