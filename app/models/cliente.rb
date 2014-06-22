#encoding: utf-8

class Cliente < ActiveRecord::Base
  validates_presence_of :nome, :message => " - deve ser preenchido"
  validates_uniqueness_of :nome, :message => " - nome já cadastrado"
  validates_numericality_of :idade,
                            :greater_than => 0,
                            :less_than => 100,
                            :message => " - deve ser um número entre 0 e 100"
  validate :primeira_letra_deve_ser_maiuscula

  private
  def primeira_letra_deve_ser_maiuscula
    errors.add("nome", "primeira letra deve ser maiúscula") unless nome =~ /[A-Z].*/
  end

  has_many :qualificacoes
end
