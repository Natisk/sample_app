# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: '_sample_app_session', expires_in: 6.hours
