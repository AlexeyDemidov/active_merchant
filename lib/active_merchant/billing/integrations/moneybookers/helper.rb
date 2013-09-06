module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Moneybookers
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :account, 'pay_to_email'
          mapping :order, 'transaction_id'
          mapping :amount, 'amount'
          mapping :currency, 'currency'

          mapping :customer,
            :first_name => 'firstname',
            :last_name  => 'lastname',
            :email      => 'pay_from_email',
            :phone      => 'phone_number'

          mapping :billing_address,
            :city     => 'city',
            :address1 => 'address',
            :address2 => 'address2',
            :state    => 'state',
            :zip      => 'postal_code',
            :country  => 'country'

          mapping :notify_url, 'status_url'
          mapping :return_url, 'return_url'
          mapping :cancel_return_url, 'cancel_url'
          mapping :description, 'detail1_text'

          mapping :recipient_description, 'recipient_description'
          mapping :return_url_text, 'return_url_text'
          mapping :return_url_target, 'return_url_target'
          mapping :cancel_url_text, 'cancel_url_text'
          mapping :status_url2, 'status_url2'
          mapping :language, 'language'
          mapping :hide_login, 'hide_login'
          mapping :confirmation_note, 'confirmation_note'
          mapping :logo_url, 'logo_url'
          mapping :title, 'title'
          mapping :date_of_birth, 'date_of_birth'
          mapping :amount2_description, 'amount2_description'
          mapping :amount2, 'amount2'
          mapping :amount3_description, 'amount3_description'
          mapping :amount3, 'amount3'
          mapping :amount4_description, 'amount4_description'
          mapping :amount4, 'amount4'
          mapping :detail1_description, 'detail1_description'
          mapping :detail1_text, 'detail1_text'
          mapping :detail2_description, 'detail2_description'
          mapping :detail2_text, 'detail2_text'
          mapping :detail3_description, 'detail3_description'
          mapping :detail3_text, 'detail3_text'
          mapping :detail4_description, 'detail4_description'
          mapping :detail4_text, 'detail4_text'
          mapping :detail5_description, 'detail5_description'
          mapping :detail5_text, 'detail5_text'

          MAPPED_COUNTRY_CODES = {
            'SE' => 'SV',
            'DK' => 'DA'
          }

          SUPPORTED_COUNTRY_CODES = [
            'FI', 'DE', 'ES', 'FR',
            'IT','PL', 'GR', 'RO',
            'RU', 'TR', 'CN', 'CZ', 'NL'
          ]

          def initialize(order, account, options = {})
            super
            add_tracking_token
            add_default_parameters
            add_seller_details(options)
          end

          private

          def add_tracking_token
            return if application_id.blank? || application_id == 'ActiveMerchant'

            add_field('merchant_fields', 'platform')
            add_field('platform', application_id)
          end

          def add_default_parameters
            add_field('hide_login', 1)
          end

          def add_seller_details(options)
            add_field('recipient_description', options[:account_name]) if options[:account_name]
            add_field('country', lookup_country_code(options[:country], :alpha3)) if options[:country]
            add_field('language', locale_code(options[:country])) if options[:country]
          end

          def locale_code(country_code)
            return country_code if SUPPORTED_COUNTRY_CODES.include?(country_code)
            MAPPED_COUNTRY_CODES[country_code] || 'EN'
          end
        end
      end
    end
  end
end
