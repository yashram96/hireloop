/*
  # Create generated resumes table

  1. New Tables
    - `generated_resumes`
      - `id` (uuid, primary key)
      - `campaign_id` (uuid, references campaigns)
      - `filename` (text)
      - `url` (text)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)

  2. Security
    - Enable RLS
    - Add policies for users to manage their own resumes
*/

CREATE TABLE IF NOT EXISTS generated_resumes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id uuid REFERENCES campaigns(id) ON DELETE CASCADE,
  filename text NOT NULL,
  url text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE generated_resumes ENABLE ROW LEVEL SECURITY;

-- Create policy to allow users to manage their own resumes
CREATE POLICY "Users can manage their own resumes"
  ON generated_resumes
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM campaigns c
      WHERE c.id = generated_resumes.campaign_id
      AND c.user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM campaigns c
      WHERE c.id = generated_resumes.campaign_id
      AND c.user_id = auth.uid()
    )
  );

-- Create updated_at trigger
CREATE TRIGGER update_generated_resumes_updated_at
  BEFORE UPDATE ON generated_resumes
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();