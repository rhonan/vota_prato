class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def novo_comentario(comentavel)
    comentarios = render(:partial => "comentarios/novo_comentario", :locals => { :comentavel => comentavel })
    raw comentarios
  end
end
