require 'rails_helper'

feature 'visitor_filter_properties' do
  scenario 'successfully' do
    #cria os dados necessarios

    purpose = Purpose.create(name:'ferias')

    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', owner: 'vo Carlos')

    PropertyPurpose.create(property: property , purpose: purpose )

    another_property = Property.create(title:'Apartamento Biscoito', city: 'Rio de Janeiro', state: 'RJ', property_type_id: property_type.id,
                              description: 'Apartamento grande na região de Copacabana',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão em qualquer lugar do Rio', owner: 'vo Carlos')

    PropertyPurpose.create(property: another_property , purpose: purpose )
    #simula a acao do usuario
    visit root_path
    fill_in 'filter', with: 'Sao Paulo'
    click_on 'Filtrar'

    expect(page).to have_css('li', text: 'Sao Paulo')
    expect(page).not_to have_css('li', text: 'Rio de Janeiro')
  end
  scenario 'and there is no property' do

    purpose = Purpose.create(name:'ferias')

    property_type = PropertyType.create(name: 'sitio')

    property = Property.create(title: 'Apartamento Top', city: 'Sao Paulo', state: 'SP', property_type_id: property_type.id,
                              description: 'Apartamento grande na região do Paraisópolis',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão e tem que fumar o colchão', owner: 'vo Carlos')

    PropertyPurpose.create(property: property , purpose: purpose )

    another_property = Property.create(title:'Apartamento Biscoito', city: 'Rio de Janeiro', state: 'RJ', property_type_id: property_type.id,
                              description: 'Apartamento grande na região de Copacabana',
                              daily_rate: 50, photo: 'apartamento.png', maximum_guests: 20, minimun_rent: 1, maximum_rent: 5,
                              rules: 'Não pode faltar o pancadão em qualquer lugar do Rio', owner: 'vo Carlos')

    PropertyPurpose.create(property: another_property , purpose: purpose )

    visit root_path
    fill_in 'filter', with: 'Curitiba'
    click_on 'Filtrar'

    expect(page).to have_css('h2', text: 'Nenhum imovel encontrado nessa cidade.')
  end



end
