class Prato < ActiveRecord::Base
  validates_presence_of :nome, :message => " - deve ser preenchido"
  validates_uniqueness_of :nome, :message => " - nome já cadastrado"
  validate :primeira_letra_deve_ser_maiuscula

  private
  def primeira_letra_deve_ser_maiuscula
    errors.add("nome", "primeira letra deve ser maiúscula") unless nome =~ /[A-Z].*/
  end

  has_and_belongs_to_many :retaurantes
  has_one :receita

  validate :validate_presence_of_more_than_one_restaurante

  def validate_presence_of_more_than_one_restaurante
    errors.add("restaurantes", "deve haver ao menos um restaurante") if restaurantes.empty?
  end

end
