class Student
  attr_reader :id
  attr_accessor :name, :grade

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end 
  
  def self.create_table
    sql = "CREATE TABLE students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    drop_table = "DROP TABLE students"
    DB[:conn].execute(drop_table)
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

  def save
    sql = "INSERT INTO students (name, grade)
            VALUES(?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end  
end
