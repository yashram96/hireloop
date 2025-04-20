/*
  # Career Info Tables

  1. New Tables
    - `education`
      - Stores user's academic background
      - Links to profiles table
    - `work_experience`
      - Stores work history
      - Links to profiles table
    - `certifications`
      - Stores professional certifications
      - Links to profiles table
    - `skills`
      - Stores user skills with categories
      - Links to profiles table
    - `projects`
      - Stores portfolio projects
      - Links to profiles table
    - `languages`
      - Stores language proficiencies
      - Links to profiles table

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to manage their own data
*/

-- Education table
CREATE TABLE IF NOT EXISTS education (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  degree_name text NOT NULL,
  institution text NOT NULL,
  start_date date,
  end_date date,
  grade text,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE education ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own education entries"
  ON education
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Work Experience table
CREATE TABLE IF NOT EXISTS work_experience (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  job_title text NOT NULL,
  company text NOT NULL,
  location text,
  start_date date NOT NULL,
  end_date date,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE work_experience ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own work experience entries"
  ON work_experience
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Certifications table
CREATE TABLE IF NOT EXISTS certifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL,
  issuing_organization text NOT NULL,
  issue_date date NOT NULL,
  expiry_date date,
  credential_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE certifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own certifications"
  ON certifications
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Skills table
CREATE TABLE IF NOT EXISTS skills (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL,
  category text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE skills ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own skills"
  ON skills
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text,
  technologies text[],
  url text,
  github_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own projects"
  ON projects
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Languages table
CREATE TABLE IF NOT EXISTS languages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL,
  proficiency text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE languages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage their own languages"
  ON languages
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Add updated_at triggers
CREATE TRIGGER update_education_updated_at
  BEFORE UPDATE ON education
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_work_experience_updated_at
  BEFORE UPDATE ON work_experience
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_certifications_updated_at
  BEFORE UPDATE ON certifications
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_skills_updated_at
  BEFORE UPDATE ON skills
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_projects_updated_at
  BEFORE UPDATE ON projects
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_languages_updated_at
  BEFORE UPDATE ON languages
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();