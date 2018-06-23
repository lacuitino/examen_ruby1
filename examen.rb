def opcion1
  #ESTA ES LA FORMA ORIGINAL EN QUE YO LO PENSÉ E HICE, LUEGO ME DI CUENTA QUE HABIA una
  #FORMA QUE AHORRA BASTANTES LINEAS DE CODIGO. PERO MANTUVE LA FORMA ORIGINAL

  #AQUI ABRO EL ARCHIVO Y LO GUARDO LAS LINEAS EN UN ARREGLO DATA
  file = File.open('alumnos.csv','r')
  data = file.readlines.map { |e| e.chomp  }
  file.close

  #AQUI HAGO CADA LINEA UN ARREGLO, USANDO DE REFERENCIA LA COMA ENTREMEDIO DE CADA VALOR,
  #LOGRANDO ASI UN ARREGLO DE ARREGLOS
  data = data.map do |x|
    x.split(', ')
  end

  #AQUI SEPARO LOS NOMBRES EN UN ARREGLO DIFERENTE Y DEJO DATA SOLO CON LAS NOTAS
  nombres = data.map do |y|
      y.delete_at(0)
  end

  #AQUI RECORRO CADA ARREGLO DENTRO DEL ARREGLO PARA CAMBIAR VALORES A FLOAT
  data = data.map do |a|
    a.map do |x|
      x.to_f
    end
  end

  #AQUI ME PROPUSE A HACER EL CALCULO DEL PROMEDIO, RECORRIENDO EL ARRELO, Y HACIENDO
  #QUE CADA SUB-ARREGLO SUME SU CONTENIDO Y LO DIVIDA POR EL TOTAL DE CONTENIDO, GUARDANDO
  #EL RESULTADO EN EL ARREGLO "PROMEDIO"
  promedio = data.map do |r|
    r.inject(&:+)/r.size
  end

  #AQUI COMBINÉ LOS DOS ARREGLOS EN UN HASH HACIENDO LOS NOMBRES COMO KEY Y LOS PROMEDIOS
  #COMO VALORES. KEY => VALUE.
  hash = nombres.zip(promedio)

  #AQUI CREÉ UN NUEVO ARCHIVO DONDE INGRESÉ EL HASH, MOSTRANDO EL KEY, VALUE.
  nuevo = File.open('promedio_alumnos.csv','a')
  hash.each do |k,v|
    nuevo.puts "#{k}, #{v}"
  end
  nuevo.close
end

def opcion2
  file = File.open('alumnos.csv','r')
  data = file.readlines.map{ |x| x.split(', ')  }
  file.close

  data = data.map do |a|
    a.map do |b|
      b.chomp
    end
  end

  data = data.flatten

  cont = 0
  data.each do |x|
    if x == "A"
      cont += 1
    end
  end

  puts '-----------------'
  puts '-----------------'
  puts "la cantidad de inasistencias son #{cont}"
  puts '-----------------'
  puts '-----------------'
end

def opcion3
  file = File.open('alumnos.csv','r')
  data = file.readlines.map { |e| e.chomp  }
  file.close

  data = data.map do |x|
    x.split(', ')
  end

  nombres = data.map do |y|
      y.delete_at(0)
  end

  data = data.map do |a|
    a.map do |x|
      x.to_f
    end
  end

  promedio = data.map do |r|
    r.inject(&:+)/r.size
  end

  puts '-----------------'
  puts '-----------------'
  promedio.size.times do |i|
    puts nombres[i] if promedio[i] >= 5
  end
  puts '-----------------'
  puts '-----------------'

end

op = 0
while op!=4
  puts ''
  puts '-------------------- MENU PRINCIPAL -------------------'
  puts '1. Generar archivo con promedio por alumno'
  puts '2. Mostrar cantidad de inasistencias totales por alumno'
  puts '3. Alumnos aprobados'
  puts '4. Salir'
  puts '-------------------------------------------------------'
  puts 'ingrese opción de 1 a 4'

  op = gets.chomp.to_i

  case op

  when 1
    opcion1
  when 2
    opcion2
  when 3
    opcion3
  when 4
    puts 'Finalizando Programa...'
  else
    puts ''
    puts '-----------------------------------------'
    puts 'Error, debe ingresar una opción de 1 a 4'
    puts '-----------------------------------------'
  end
end
