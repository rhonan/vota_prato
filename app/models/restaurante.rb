#encoding: utf-8

class Restaurante < ActiveRecord::Base

  validates_presence_of :nome, :message => "deve ser preenchido"
  validates_presence_of :endereco, :message => "deve ser preenchido"
  validates_presence_of :especialidade, :message => "deve ser preenchido"
  validates_uniqueness_of :nome, :message => "nome já cadastrado"
  validates_uniqueness_of :endereco, :message => "endereço já cadastrado"

  validate :primeira_letra_deve_ser_maiuscula

  private
  def primeira_letra_deve_ser_maiuscula
    errors.add(:nome,"deve ter primeira letra maiúscula") unless nome =~ /[A-Z].*/
  end

  has_many :qualificacoes
  has_and_belongs_to_many :pratos

  scope :massas, -> {where({ :especialidade => 'massas' })}
  scope :recentes, -> {where([ "created_at > ?", 3.months.ago ])}
  scope :pelo_nome, -> {order('nome')}
  scope :espoca_buxo, -> {where({ :especialidade => 'Espoca buxo' })}
end
