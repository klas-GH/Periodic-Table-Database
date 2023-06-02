PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

resp_db() { 

  symbol_ID=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$atomic_number_ID")
  name_ID=$($PSQL "SELECT name FROM elements WHERE atomic_number=$atomic_number_ID")
  
  mass_ID=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$atomic_number_ID")
  melt_ID=$($PSQL "SELECT  melting_point_celsius FROM properties WHERE atomic_number=$atomic_number_ID")
  boil_ID=$($PSQL "SELECT  boiling_point_celsius FROM properties WHERE atomic_number=$atomic_number_ID")
  type_IDP=$($PSQL "SELECT  type_id FROM properties WHERE atomic_number=$atomic_number_ID")
  type_IDD=$($PSQL "SELECT type FROM types WHERE type_id=$type_IDP")

  echo -e "The element with atomic number $atomic_number_ID is $name_ID ($symbol_ID). It's a $type_IDD, with a mass of $mass_ID amu. $name_ID has a melting point of $melt_ID celsius and a boiling point of $boil_ID celsius." 

}


if [[ $1 ]]
then


  if [[ $1 =~ ^[0-9]+$ ]]
  then
    atomic_number_ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    if [[  $atomic_number_ID ]]
    then
        resp_db
    else
      echo -e "I could not find that element in the database."
    fi
  #fi

  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    atomic_number_ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    if [[  $atomic_number_ID ]]
    then
      resp_db          
    else
      echo -e "I could not find that element in the database."
    fi
  #fi

  elif [[ $1 =~ ^[A-Z][a-z][a-z]+$ ]]
  then
    atomic_number_ID=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    if [[  $atomic_number_ID ]]
    then
     resp_db
    else
      echo -e "I could not find that element in the database."
    fi
  else
    echo -e "I could not find that element in the database."
  fi


else
  echo "Please provide an element as an argument."
fi
