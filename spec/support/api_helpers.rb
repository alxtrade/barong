# frozen_string_literal: true

module APIHelpers
  extend Memoist

  def json_body
    JSON.parse(response.body, symbolize_names: true)
  end

  def expect_status_to_eq(status)
    expect_status.to eq status
  end

  def expect_status
    expect(response.status)
  end

  def expect_body
    expect(json_body)
  end

  def post_json(destination, body, headers = {})
    post destination,
         params: build_body(body),
         headers: headers.reverse_merge('Content-Type' => 'application/json')
  end

  def put_json(destination, body, headers = {})
    put destination,
        params: build_body(body),
        headers: headers.reverse_merge('Content-Type' => 'application/json')
  end

  def build_body(body)
    body.is_a?(String) ? body : body.to_json
  end

  def create_label_with_level(user, level, scope: 'private')
    create(:label, user: user,
                   key: level.key,
                   value: level.value,
                   scope: scope)
  end

  def set_level(user, level)
    raise "level doesn't exist" if Level.last.id < level
    levels = Level.where(id: 1..level)
    levels.each do |lvl|
      Label.find_or_create_by(user: user, key: lvl.key, value: lvl.value, scope: 'private')
    end
  end
end

RSpec.configure { |config| config.include APIHelpers }
