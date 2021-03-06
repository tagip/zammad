FactoryBot.define do
  factory 'knowledge_base/category', aliases: %i[knowledge_base_category] do
    knowledge_base { parent&.knowledge_base || create(:knowledge_base) }
    category_icon  { 'f04b' }
  end

  factory 'kb_category_with_tree', parent: 'knowledge_base/category' do
    after(:create) do |obj|
      create(:knowledge_base_category, parent: obj)

      level2 = create(:knowledge_base_category, parent: obj)
      2.times { create(:knowledge_base_category, parent: level2) }

      level3 = level2.children.reload.first
      2.times { create(:knowledge_base_category, parent: level3) }

      obj.reload
    end
  end
end
