/*
  # Add LinkedIn OAuth Connections

  1. New Tables
    - `oauth_connections`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references profiles)
      - `provider` (text) - OAuth provider name
      - `provider_user_id` (text) - User ID from provider
      - `access_token` (text) - OAuth access token
      - `refresh_token` (text) - OAuth refresh token
      - `expires_at` (timestamptz) - Token expiration
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)

  2. Security
    - Enable RLS
    - Add policies for users to manage their own connections
*/

CREATE TABLE IF NOT EXISTS oauth_connections (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  provider text NOT NULL,
  provider_user_id text,
  access_token text,
  refresh_token text,
  expires_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id, provider)
);

ALTER TABLE oauth_connections ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own connections"
  ON oauth_connections
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE TRIGGER update_oauth_connections_updated_at
  BEFORE UPDATE ON oauth_connections
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();