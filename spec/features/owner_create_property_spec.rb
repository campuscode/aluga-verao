require 'rails_helper'

feature 'Owner create property' do

  scenario 'successfully' do

    #criar um imovel
    property = Property.create( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', price: 90.0, photo: 'sitio.jpg',
                                capacity: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias', owner: 'vo Carlos')



    #simula o cadastro
    visit root_path
    click_on 'Cadastrar Imovel'
    #preencher o form
    fill_in 'Descricao', with: property.description
    fill_in 'Cidade', with: property.city
    fill_in 'Estado', with: property.state
    fill_in 'Tipo', with: property.property_type
    fill_in 'Preco', with: property.price
    fill_in 'Capacidade', with: property.capacity
    fill_in 'Max Pessoas', with: property.maximum_rent
    fill_in 'Min Pessoas', with: property.minimun_rent
    fill_in 'Regras', with: property.rules
    fill_in 'Finalidade', with: property.rent_purpose
    fill_in 'Dono', with: property.owner

    click_on 'Enviar'

    #excepct stranger things
    expect(page).to have_css('h1', property.description)
    expect(page).to have_css('li', property.state)
    expect(page).to have_css('li', property.city)
    expect(page).to have_css('li', property.property_type)
    expect(page).to have_css('li', property.price)
    expect(page).to have_css('li', property.capacity)
    expect(page).to have_css('li', property.maximum_rent)
    expect(page).to have_css('li', property.minimun_rent)
    expect(page).to have_css('li', property.rules)
    expect(page).to have_css('li', property.rent_purpose)
    expect(page).to have_css('li', property.owner)

  end

  scenario 'and must fill owner' do

    property = Property.new( city: 'SaoPaulo', state: 'SP', property_type: 'sitio', description: 'sitio do meu vo', price: 90.0, photo: 'sitio.jpg',
                                capacity: 5, minimun_rent: 2, maximum_rent: 3, rules: 'varias regras mimimi', rent_purpose: 'ferias')


    visit root_path

    click_on 'Cadastrar Imovel'
    fill_in 'Descricao', with: property.description
    fill_in 'Cidade', with: property.city
    fill_in 'Estado', with: property.state
    fill_in 'Tipo', with: property.property_type
    fill_in 'Preco', with: property.price
    fill_in 'Capacidade', with: property.capacity
    fill_in 'Max Pessoas', with: property.maximum_rent
    fill_in 'Min Pessoas', with: property.minimun_rent
    fill_in 'Regras', with: property.rules
    fill_in 'Finalidade', with: property.rent_purpose

    click_on 'Enviar'

    expect(page).to have_content('Este imovel nao pode ser cadastrado sem um proprietario')

  end
end
