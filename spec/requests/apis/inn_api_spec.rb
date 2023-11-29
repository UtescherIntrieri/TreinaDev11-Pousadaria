require 'rails_helper'

describe 'Inn API' do
  context 'GET /api/v1/inns/1' do
    it 'success' do
      # Arrange
      host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
      inn = Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
      registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
      email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
      city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
      description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
      pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
      check_in: '13:00:00', check_out: '14:00:00', host_id: host.id)
      
      # Act
      get "/api/v1/inns/#{inn.id}"
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json' 
      json_response = JSON.parse(response.body)
      expect(json_response["corporate_name"]).to eq("Pousadas Guaraú")
      expect(json_response["brand_name"]).to eq("Pousada na floresta")
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it 'fail if inn not found' do
      # Arrange
      
      # Act
      get "/api/v1/inns/99999"
      
      # Assert
      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/inns' do
    it 'success' do
      # Arrange
      host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
      inn = Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
      registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
      email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
      city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
      description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
      pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
      check_in: '13:00:00', check_out: '14:00:00', host_id: host.id)
      
      # Act
      get '/api/v1/inns'
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]["brand_name"]).to eq "Pousada na floresta"
    end
    
    it 'return empty if there is no inn' do
      # Arrange
      
      
      # Act
      get '/api/v1/inns'
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
      
    end
  end
end