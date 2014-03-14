class FilingsController < ApplicationController
  before_action :set_filing, only: [:show, :edit, :update, :destroy]

  def archive
    require 'rest_client'
    require 'feedzirra'
    require 'nokogiri'
    require 'open-uri'

  end

  # GET /filings
  # GET /filings.json
  def index
    import
    @filings = Filing.all
    @companies = Company.all
  end

  def import
    require 'feedzirra'
    require 'rubygems'
    require 'sanitize'

    feed = Feedzirra::Feed.fetch_and_parse("http://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=&company=&dateb=&owner=include&start=0&count=100&output=atom")
      feed.entries.each do |entry|
        fireimport(entry)
      end
  end

  def fireimport(entry)
    hold_cik = entry.title.match('\d{10}').to_s
    hold_id = entry.entry_id.sub("urn:tag:sec.gov,2008:accession-number=", "")

    @company = Company.find_or_initialize_by(cik: hold_cik )

    @filing = @company.filings.find_or_initialize_by(file_serial: hold_id)

    @filing.cik        = hold_cik
    @filing.title      = entry.title.sub( entry.categories.join(" ") + " - ", '').sub('(' + @filing.cik + ')' , '').sub('(Issuer)' , '').sub('(Reporting)' , '').sub('(Filer)' , '').sub('(Filed by)' , '').sub('(Subject)' , '').strip
    @filing.url        = entry.url
    @filing.links      = entry.links.join(" ")
    @filing.summary    = entry.summary 
    @filing.updated    = entry.updated 
    @filing.categories = entry.categories.join(" ").strip
    @filing.file_serial    = entry.entry_id.sub("urn:tag:sec.gov,2008:accession-number=", "")
          
          @company.cik = @filing.cik 
          @company.name = @filing.title.sub( '(' + @filing.cik + ')', '').sub('(' + @filing.cik + ')' , '').sub('(Issuer)' , '').sub('(Reporting)' , '').sub('(Filer)' , '').sub('(Filed by)' , '').sub('(Subject)' , '').strip
          @company.save

    @filing.save
    
  end

  def backlog

    require 'feedzirra'
    require 'rubygems'
    require 'sanitize'

    start = 0

    while start < 10000  do

      feed = Feedzirra::Feed.fetch_and_parse("http://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=&company=&dateb=&owner=include&start=#{start}&count=200&output=atom")
        feed.entries.each do |entry|
          fireimport(entry)
        end

      start = start + 100

    end
  
    @filings = Filing.all
    render template: "filings/index"

  end

  #def importer
    #@filings = Filing.all
  #  #render template: "filings/importer"
  #end

  # GET /filings/1
  # GET /filings/1.json
  def show
    @company = Company.find_by("cik = ?", @filing.cik)
  end

  # GET /filings/new
  def new
    @filing = Filing.new
  end

  # GET /filings/1/edit
  def edit
  end

  # POST /filings
  # POST /filings.json
  def create
    @filing = Filing.new(filing_params)

    respond_to do |format|
      if @filing.save
        format.html { redirect_to @filing, notice: 'Filing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @filing }
      else
        format.html { render action: 'new' }
        format.json { render json: @filing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filings/1
  # PATCH/PUT /filings/1.json
  def update
    respond_to do |format|
      if @filing.update(filing_params)
        format.html { redirect_to @filing, notice: 'Filing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @filing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filings/1
  # DELETE /filings/1.json
  def destroy
    @filing.destroy
    respond_to do |format|
      format.html { redirect_to filings_url }
      format.json { head :no_content }
    end
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filing
      @filing = Filing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filing_params
      params.require(:filing).permit(:title, :url, :links, :summary, :updated, :categories, :id)
    end


end
