require 'rails_helper'

describe ImportCsv do
  let!(:file) { fixture_file_upload('spec/fixtures/products.csv') }
  let!(:service) { Products::Importor.new(file_import: file) }

  specify do
    expect(service.success?).to eq false
    expect(service.csv_valid?).to eq true
  end
end

