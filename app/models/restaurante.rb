#encoding: utf-8

class Restaurante < ActiveRecord::Base

  has_attached_file :foto#, :styles => { :thumb => "100x100#", :small  => "150x150>", :medium => "200x200" }, :convert_options => { :thumb => "-quality 75 -strip" }
  validates_attachment_content_type :foto, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
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
  has_many :comentarios, :as => :comentavel
  has_and_belongs_to_many :pratos

  scope :massas, -> {where({ :especialidade => 'massas' })}
  scope :recentes, -> {where([ "created_at > ?", 3.months.ago ])}
  scope :pelo_nome, -> {order('nome')}
  scope :espoca_buxo, -> {where({ :especialidade => 'Espoca buxo' })}
end
