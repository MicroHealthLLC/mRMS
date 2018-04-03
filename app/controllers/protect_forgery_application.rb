class ProtectForgeryApplication < ApplicationController
  protect_from_forgery with: :exception
end